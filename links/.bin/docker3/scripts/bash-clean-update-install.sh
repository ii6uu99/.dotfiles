#!/bin/bash
## Description: Test for yum or apt based linux, and install packages (for BaSH)

## HOW TO USE:
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/bash-clean-update-install.sh | bash /dev/stdin [package1 [package2...]]

. <( curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/bash-check-pkg-manager.sh )

if [[ -n "$IS_YUM_PKG_MANAGER" ]]; then
    curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/yum/clean-update-install.sh | bash /dev/stdin $*
else
    if [[ -n "$IS_APT_GET_PKG_MANAGER" ]]; then
        curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/apt-get/clean-update-install.sh | bash /dev/stdin $*
    fi
fi
