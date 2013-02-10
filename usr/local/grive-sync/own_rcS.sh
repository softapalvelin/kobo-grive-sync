#!/bin/sh

BASEDIR=$(dirname $0)

# export variables
. $BASEDIR/config.sh

# ensure that SD card is ready or create virtual SD card
$grive_sync_home/virtual_sd.sh

# refresh library at boot only if real SD is not connected and sync is used
# if real SD card is connected firmware handles sync
# koboExtStorage is created when sync is used
if [ ! -e /dev/mmcblk1p1 ] && [ -d /mnt/sd/koboExtStorage ]; then
      $grive_sync_home/refresh_library.sh
fi

