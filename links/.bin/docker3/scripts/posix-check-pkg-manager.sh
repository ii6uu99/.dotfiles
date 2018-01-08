#!/bin/sh
## Description: Test for yum or apt based linux (requires which command)

## HOW TO USE:
# named_pipe=`cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 32` && mkfifo $named_pipe && (curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-check-pkg-manager.sh > $named_pipe &) && . /dev/stdin < $named_pipe && rm -f $named_pipe


export IS_YUM_PKG_MANAGER=`which yum 1>/dev/null 2>/dev/null && echo 1 || echo ''`
export IS_APT_GET_PKG_MANAGER=`which apt-get 1>/dev/null 2>/dev/null && echo 1 || echo ''`
export PKG_MANAGER=$( which yum || which apt-get ) || exit 1
