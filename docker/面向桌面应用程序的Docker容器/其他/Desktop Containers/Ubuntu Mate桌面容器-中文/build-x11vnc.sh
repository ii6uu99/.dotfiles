#!/usr/bin/env bash

sudo apt-get -y build-dep x11vnc
sudo apt-get -y install fakeroot checkinstall
wget -O- http://x11vnc.sourceforge.net/dev/x11vnc-0.9.14-dev.tar.gz | tar zxf -
cd x11vnc-0.9.14/
./configure
make
sudo checkinstall -D --install=no -y --pkgname=x11vnc --pkgversion=0.9.14 \
--pkgsource="http://x11vnc.sourceforge.net/dev/x11vnc-0.9.14-dev.tar.g" make
