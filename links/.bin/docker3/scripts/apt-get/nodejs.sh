#!/bin/sh
## Description: Install NodeJS

## HOW TO USE (as root):
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/apt-get/nodejs.sh | sh /dev/stdin

DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -yq update && \
DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -yq install git subversion nodejs npm && \
rm -rf /var/lib/apt/lists/*
