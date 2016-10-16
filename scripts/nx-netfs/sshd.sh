#!/bin/bash

source /opt/usr/nx-ks/nx-netfs/common.sh

if [[ $1 = "start" ]]; then
    run_mount
    run_jail /etc/init.d/S50sshd start
elif [[ $1 = "stop" ]]; then
    run_jail /etc/init.d/S50sshd stop
fi
