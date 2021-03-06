#!/bin/bash

#install backports kernl

if [[ $EUID -ne 0 ]]; then
   echo "这个脚本必须以root身份运行" 1>&2
   exit 1
fi

echo "deb http://ftp.debian.org/debian/ wheezy-backports main non-free contrib" | tee /etc/apt/sources.list.d/backports.list
apt-get update
apt-get -t jessie-backports install linux-image-amd64 linux-headers-amd64
