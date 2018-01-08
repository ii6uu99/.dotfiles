#!/bin/sh
## Description: Test for yum or apt based linux, and install packages (POSIX)

## HOW TO USE:
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin [package1 [package2...]]

named_pipe=`cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 32` && mkfifo $named_pipe && (curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-check-pkg-manager.sh > $named_pipe &) && . /dev/stdin < $named_pipe && rm -f $named_pipe

if [ -n "$IS_YUM_PKG_MANAGER" ]; then
    curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/yum/clean-update-install.sh | sh /dev/stdin $*
else
    if [ -n "$IS_APT_GET_PKG_MANAGER" ]; then
        curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/apt-get/clean-update-install.sh | sh /dev/stdin $*
    fi
fi
