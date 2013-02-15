#!/bin/sh

# note: in firmware 2.3.1 this is not always executed by udev, but also by nickel (maybe)

BASEDIR=$(dirname $0)
. $BASEDIR/config.sh

if [ "$ACTION" == "remove" ]; then
  {
    date
    echo "$0: USB removed. Checking virtual SD."
    $grive_sync_home/virtual_sd.sh
  } &> $grive_sync_settings/last-usb-remove.txt
fi
