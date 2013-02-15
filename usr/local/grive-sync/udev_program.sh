#!/bin/sh

# http://www.reactivated.net/writing_udev_rules.html#example-netif

if [ "$ACTION" != "add" ]; then
      exit 1;
fi

BASEDIR=$(dirname $0)
. $BASEDIR/config.sh
$BASEDIR/sync.sh &> $grive_sync_settings/last-grive-sync.txt &
