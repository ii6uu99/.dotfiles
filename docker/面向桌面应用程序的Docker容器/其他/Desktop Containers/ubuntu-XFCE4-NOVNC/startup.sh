#!/bin/bash
su - tux -c "echo $VNCPASS | vncpasswd -f > /home/tux/.vnc/passwd" &&
su - tux -c "chmod 600 /home/tux/.vnc/passwd" &&
su - tux -c "vncserver :0 -SecurityTypes VncAuth -AcceptSetDesktopSize=1" &&
echo 'tux:$VNCPASS' | chpasswd &&
cd /root/noVNC && ln -s vnc.html index.html && ./utils/launch.sh --web /root/noVNC --vnc localhost:5900
