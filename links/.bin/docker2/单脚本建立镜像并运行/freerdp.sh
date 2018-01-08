#!/usr/bin/env bash

image=$(basename $0 .sh)
user=${USER:-root}
home=${HOME:-/home/$user}
uid=${UID:-1000}
gid=${uid:-1000}
thisdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
tmpdir=$(mktemp -d)

echo "FROM ubuntu:14.04

RUN apt-get update \\
 && apt-get -y install build-essential git-core cmake xsltproc libssl-dev libx11-dev libxext-dev libxinerama-dev \\
            libxcursor-dev libxdamage-dev libxv-dev libxkbfile-dev libasound2-dev libcups2-dev libxml2 libxml2-dev \\
            libxrandr-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libxi-dev libgstreamer-plugins-base1.0-dev \\
            libavutil-dev libavcodec-dev \\
 && apt-get -y install xterm

# use my branch with increased timeout (the problem https://github.com/FreeRDP/FreeRDP/pull/2936 still exists)
RUN git clone https://github.com/volth/FreeRDP.git \\
 && cd /FreeRDP \\
 && git checkout volth \\
 && cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_DEBUG_CLIPRDR=ON -DWITH_LIBSYSTEMD=OFF -DWITH_WAYLAND=OFF -DWITH_MANPAGES=OFF -DWITH_SSE2=ON . \\
 && make install

# freerdp-xfce-hotkeys.sh needs this
RUN apt-get -y install wmctrl gawk

RUN mkdir -p ${home} \\
 && chown ${uid}:${gid} -R ${home} \\
 && echo \"${user}:x:${uid}:${gid}:${user},,,:${home}:/bin/bash\" >> /etc/passwd \\
 && echo \"${user}:x:${uid}:\"                                    >> /etc/group \\
 && [ -d /etc/sudoers.d ] || (apt-get update && apt-get -y install sudo) \\
 && echo \"${user} ALL=(ALL) NOPASSWD: ALL\"                       > /etc/sudoers.d/${user} \\
 && chmod 0440 /etc/sudoers.d/${user}
USER ${user}
ENV HOME ${home}

CMD /usr/local/bin/xfreerdp $*
" > $tmpdir/Dockerfile

docker build -t $image $tmpdir
rm -rf $tmpdir

# hotkeys pressed when xfreerdp run fullscreen handled by the same script
# which handles xfce global (the same) hotkeys outside the containr
# "/usr/share/freerdp/action.sh" is hardcoded in FreeRDP

# this may be run under Java's `Runtime.getRuntime.exec` or from XFCE menu, in this case no `docker -t` nor `docker -i` start
ti() {
  stty -a >/dev/null
  if [ $? -eq 0 ]; then echo "-ti"; fi
}

docker run $(ti) -e DISPLAY --net=host -v $HOME/.Xauthority:${home}/.Xauthority:ro -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ${thisdir}/freerdp-xfce-hotkeys.sh:/usr/share/freerdp/action.sh:ro \
  --memory=1000mb \
  --rm $image
