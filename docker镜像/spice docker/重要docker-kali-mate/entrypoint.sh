#!/bin/bash

/usr/bin/Xorg -config /etc/spice-server-config/spiceqxl.xorg.conf :2 &

DISPLAY=:2 /usr/bin/mate-session
