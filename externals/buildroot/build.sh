#!/bin/bash

BR_VER=2016.08.1
BR_TAR=buildroot-$BR_VER.tar.bz2
BR_DIR=buildroot-$BR_VER

wget -c https://buildroot.org/downloads/$BR_TAR

if [ -f $BR_TAR ] && [ ! -d $BR_DIR ]; then
    tar -xjf $BR_TAR
    (cd $BR_DIR/package; ln -s ../../smbnetfs)
    (cd $BR_DIR; patch -p0 < ../patch-001-package-config-in.patch)
fi

cp -fv nx_netfs_defconfig $BR_DIR/configs
cd $BR_DIR
make nx_netfs_defconfig && make
