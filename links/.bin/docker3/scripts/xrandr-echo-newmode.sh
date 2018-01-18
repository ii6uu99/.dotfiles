#!/bin/sh
## Description: Create a new mode, add it, and echo it in stdout. Configured for VNC by default.


## HOW TO USE:
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/xrandr-echo-newmode.sh | sh /dev/stdin


if [ -z "$output" ]; then
    output=VNC-0
fi

modeline=`cvt $1 $2 $3 | grep Modeline | sed 's/Modeline\s*//'`
mode=`echo $modeline | awk '{print $1}'`

xrandr --newmode $modeline
xrandr --addmode "$output" $mode
echo $mode
