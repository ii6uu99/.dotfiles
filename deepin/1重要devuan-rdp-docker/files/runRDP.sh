#!/bin/sh

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/sbin/xrdp
PIDDIR=/var/run/xrdp
USERID=xrdp
NAME=xrdp


[ -e $PIDDIR/$NAME.pid ] && rm $PIDDIR/$NAME.pid

start-stop-daemon --start --quiet --oknodo --pidfile $PIDDIR/$NAME.pid \
  --chuid $USERID:$USERID --exec $DAEMON

/usr/sbin/xrdp-sesman --nodaemon

