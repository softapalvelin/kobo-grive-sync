#!/bin/sh

# http://www.reactivated.net/writing_udev_rules.html#example-netif

if [ "$ACTION" != "add" ]; then
      exit 1;
fi

BASEDIR=$(dirname $0)
. $BASEDIR/config.sh

# some line might rely that settings directory exists
mkdir -p $grive_sync_settings

$BASEDIR/sync.sh &> $grive_sync_settings/last-grive-sync.txt &
