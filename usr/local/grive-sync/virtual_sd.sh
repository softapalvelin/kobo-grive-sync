#!/bin/sh

# create virtual SD card by bind mounting it to folder inside onboard SD.
mkdir -p $grive_sync_settings/sd/
mountpoint -q /mnt/sd || mount --bind $grive_sync_settings/sd /mnt/sd
