#!/bin/sh

# (I know config is called from udev_program.sh) keep config also here so it's easy to dev
BASEDIR=$(dirname $0)
. $BASEDIR/config.sh

# ensure that application is installed
$grive_sync_home/install_app.sh

# wait that internet connection is established
date
echo "$0: connecting..."
$grive_sync_home/ping-test.sh www.google.com
if [ $? != 0 ]; then
      echo "$0: no connection"
      exit 1;
fi
echo "$0: connected"
# ensure that SD card is ready or create virtual SD card
$grive_sync_home/virtual_sd.sh

# connection is ok. Synchronization can start.
# grive-sync-state is used to detect if there's need to refresh library
if [ -e $grive_sync_libfolder/.grive_state ]; then
  cp -p $grive_sync_libfolder/.grive_state $grive_sync_libfolder/.grive-sync-state
fi

cd $grive_sync_libfolder
# check if we should reset authentication code
if [ -e $grive_sync_settings/auth.txt ]; then
      echo "$0: auth.txt detected. Starting grive authentication.";
      cat $grive_sync_settings/auth.txt | grive -a
      rm -f $grive_sync_settings/auth.txt
fi
# synchronize
echo "$0: Starting grive";
pwd
grive
if [ $? != 0 ]; then
# error.. probably authentication error.
      echo "$0: Synchronization error. Creating README.txt";
# Let's create README.txt
      echo "SETUP GUIDE" > $grive_sync_settings/README.txt
      echo " " >> $grive_sync_settings/README.txt
      echo - | grive -a >> $grive_sync_settings/README.txt
      echo " " >> $grive_sync_settings/README.txt
      echo "Create auth.txt file inside this folder and save the authentication code there." >> $grive_sync_settings/README.txt
      echo "Then unplug the eReader and start synchronization again by clicking sync or by starting web browser." >> $grive_sync_settings/README.txt
      echo "If synchronization was succesfull, you should see koboExtStorage folder in your Google Drive. If you have books in your Google Drive, you should also see 'Loading content..' message in the eReader." >> $grive_sync_settings/README.txt
# call refresh so koboExtStorage is created
      $grive_sync_home/refresh_library.sh
      exit 1;
fi

# refresh library, but only if it needs refresh! Needless refresh will throw user to home screen.
# TODO: this counts modified files, but we need to count new files..
# exlude "Digital Editions" and "koboExtStorage" directories, because changes in there don't require refresh
modified_files_count=1
if [ -e $grive_sync_libfolder/.grive-sync-state ]; then
  modified_files_count=$(find $grive_sync_libfolder -newer $grive_sync_libfolder/.grive-sync-state -type f ! -iname ".*" -o \( -path $grive_sync_libfolder/Digital\ Editions -prune \) -type f -o \( -path $grive_sync_libfolder/koboExtStorage \) -type f | wc -l)
fi
if [ $modified_files_count != 0 ]; then
      echo "$0: $modified_files_count new file(s). Refresh library.";
      $grive_sync_home/refresh_library.sh
else
      echo "$0: No new files. Skip library refresh.";
fi

