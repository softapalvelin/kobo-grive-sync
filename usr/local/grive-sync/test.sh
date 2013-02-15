#!/bin/sh

BASEDIR=$(dirname $0)
. $BASEDIR/config.sh

  {
    date
    echo "$0: Test activated"
    export
  } &> $grive_sync_settings/last-test.txt
