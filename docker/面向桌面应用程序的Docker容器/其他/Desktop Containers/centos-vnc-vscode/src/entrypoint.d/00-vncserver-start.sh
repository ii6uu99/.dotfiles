#!/bin/bash

indent() { sed 's/^/\t/'; }

(echo $CONF_VNC_PASS && echo $CONF_VNC_PASS) | vncpasswd

vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION
vncserver -list

startxfce4 &