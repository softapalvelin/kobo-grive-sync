#!/bin/sh
mountpoint -q /mnt/sd
if [ $? != 0 ]; then
      echo "ERROR: /mnt/sd is not mounted. Can't refresh library."
      exit 1;
fi
echo sd add /dev/mmcblk1p1 >> /tmp/nickel-hardware-status
