#!/bin/sh
## Description: Do clean update, and install packages with yum, without any docs. Clear the cache at finish.

## HOW TO USE (as root):
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/yum/clean-update-install.sh | sh /dev/stdin [package1 [package2...]]


yum clean all && \
yum -y update && \
( yum -y --setopt=tsflags=nodocs install which 2>/dev/null || true ) && \
yum -y --setopt=tsflags=nodocs install curl $* && \
yum clean all && \
rm -rf /var/cache/yum/*
