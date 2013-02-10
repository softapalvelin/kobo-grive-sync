#!/bin/sh

# This config script is used with sourcing so don't call exit

# grive_sync_home is also defined in /etc/udev/rules.d/99-grive-sync.rules and rcS_payload.txt

grive_sync_settings=/mnt/onboard/.grive-sync
grive_sync_home=/usr/local/grive-sync
grive_sync_libfolder=/mnt/sd

export grive_sync_settings grive_sync_home grive_sync_libfolder
