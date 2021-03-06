#!/bin/sh

# 使用rsync进行增量备份


die() { echo "$0: fatal: $@" >&2; exit 1; }

[ "$(id -u)" = 0 ] || die must run as root

dest=${1:-bip.local:/home/backup}/$(hostname)
date=$(date +%Y%m%d_%H%M%S)
last=$(rsync --list-only $dest/ 2>/dev/null | cut -b 47- | tail -1)

case $last in
(2*) opt_link=--link-dest=../$last;;
(*) opt_link=;;
esac

rsync -DSHxav $opt_link / $dest/$date
