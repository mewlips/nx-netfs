#!/bin/bash

JAILED_ROOT=/opt/usr/nx-ks/nx-netfs/jailed_root

insmod /opt/usr/nx-ks/nx-netfs/fuse.ko

check_mount() {
    local src=$1
    local dst=$2
    mount 2>&1 | grep $dst || mount -o bind $src $dst
}

check_umount() {
    local dst=$1
    mount 2>&1 | grep $dst && umount -o $dst
}

run_mount() {
    check_mount /dev $JAILED_ROOT/dev
    check_mount /dev/pts $JAILED_ROOT/dev/pts
#    check_mount /opt/storage/sdcard $JAILED_ROOT/sdcard
    check_mount /proc $JAILED_ROOT/proc
    check_mount /sys $JAILED_ROOT/sys
#    check_mount /opt/usr $JAILED_ROOT/opt/usr
}

run_umount() {
    check_umount $JAILED_ROOT/opt/usr
    check_umount $JAILED_ROOT/sys
    check_umount $JAILED_ROOT/proc
    check_umount $JAILED_ROOT/sdcard
    check_umount $JAILED_ROOT/dev/pts
    check_umount $JAILED_ROOT/dev
}

run_jail() {
    chroot $JAILED_ROOT "$@"
}
