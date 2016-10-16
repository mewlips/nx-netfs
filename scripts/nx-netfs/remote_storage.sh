#!/bin/bash

source /opt/usr/nx-ks/nx-netfs/common.sh

cmd=$1
computer="$2"
remote_sdcard="$3"
user="$4"
password="$5"

if [[ $1 = "start" ]]; then
    echo "auth \"$user\" \"$password\"" > $JAILED_ROOT/root/.smb/smbnetfs.auth
    chmod 600 $JAILED_ROOT/root/.smb/smbnetfs.auth
    photo_dirs="$(ls /opt/storage/sdcard/DCIM)"
    umount /opt/storage/sdcard
    mount /dev/mmcblk1p1 $JAILED_ROOT/sdcard
    run_mount
    run_jail smbnetfs /mnt/smb
    run_jail unionfs "/mnt/smb/$computer/$remote_sdcard"=RW:/sdcard=RW /mnt/sdcard
    for dir in $photo_dirs; do
        mkdir -p $JAILED_ROOT/mnt/sdcard/DCIM/$dir
    done
    mkdir -p /opt/storage/sdcard/
    check_mount $JAILED_ROOT/mnt/sdcard /opt/storage/sdcard
elif [[ $1 = "stop" ]]; then
    umount /opt/storage/sdcard
    umount $JAILED_ROOT/mnt/sdcard
    umount $JAILED_ROOT/mnt/smb
    umount $JAILED_ROOT/sdcard
    mount /dev/mmcblk1p1 /opt/storage/sdcard
else
    echo usage: "$0 <start|stop> [COMPUTER] [REMOTE_SDCARD_SHARE] [USER] [PASSWORD]"
fi

