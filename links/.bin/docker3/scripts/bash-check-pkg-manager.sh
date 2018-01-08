#!/bin/bash
## Description: Test for yum or apt based linux

## HOW TO USE:
# . <( curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/bash-check-pkg-manager.sh )


export IS_YUM_PKG_MANAGER=`command -v yum &>/dev/null && echo 1 || echo ''`
export IS_APT_GET_PKG_MANAGER=`command -v apt-get &>/dev/null && echo 1 || echo ''`
export PKG_MANAGER=$( command -v yum || command -v apt-get ) || exit 1
