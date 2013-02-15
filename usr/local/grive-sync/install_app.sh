#!/bin/sh
target=/etc/init.d/rcS
payload=$grive_sync_home/rcS_payload.txt

grep -q -F -f $payload $target
if [ $? != 0 ]; then
      cat $payload >> $target
fi
 
target=/usr/local/Kobo/udev/usb
payload=$grive_sync_home/usb_payload.txt

grep -q -F -f $payload $target
if [ $? != 0 ]; then
      cat $payload >> $target
fi
 
