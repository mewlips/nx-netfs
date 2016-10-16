#!/bin/bash

cp -r /opt/storage/sdcard/nx-netfs /opt/usr/nx-ks/
cd /opt/usr/nx-ks/nx-netfs/jailed_root
tar xf ../rootfs.tar
chroot . /init_netfs.sh

# usage:
#
# cd /opt/usr/nx-ks/nx-netfs
# ./remote_storage.sh start COMPUTER SHARE USER PASSWORD
# ex) ./remote_storage.sh start MYCOM share/sdcard mewlips mypassword
# ./remote_storage.sh stop

