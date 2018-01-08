#!/bin/sh
## Description: Provide which function if this command is not available

## HOW TO USE:
# named_pipe=`cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 32` && mkfifo $named_pipe && (curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-emu-which.sh > $named_pipe &) && . /dev/stdin < $named_pipe && rm -f $named_pipe



which which 1>/dev/null 2>/dev/null || \
whereis whereis 1>/dev/null 2>/dev/null && which() { typeset p=`whereis -b $* | awk '{print \$2}'` ; ( [ -n "$p" ] && echo $p ) || false; } || \
echo "ERROR: Cannot emulate which command." 1>&2 && false

