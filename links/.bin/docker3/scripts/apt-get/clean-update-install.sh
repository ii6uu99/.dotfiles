#!/bin/sh
## Description: Do clean update, and install packages with apt-get, without any docs. Clear the cache at finish.

## HOW TO USE (as root):
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/apt-get/clean-update-install.sh | sh /dev/stdin [package1 [package2...]]


DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -yq update && \
( DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -yq install which 2>/dev/null || true ) && \
DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -yq install curl $* && \
rm -rf /var/lib/apt/lists/*
