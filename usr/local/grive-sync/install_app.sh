#!/bin/sh
target=/etc/init.d/rcS
payload=$grive_sync_home/rcS_payload.txt

grep -q -F -f $payload $target
if [ $? = 0 ]; then
      exit 0;
fi
 
cat $payload >> $target

grep -q -F -f $payload $target
if [ $? != 0 ]; then
      exit 1;
fi
