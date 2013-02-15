#!/bin/sh

BASEDIR=$(dirname $0)
. $BASEDIR/config.sh

if [ "$ACTION" == "remove" ]; then
  $grive_sync_home/virtual_sd.sh
fi
