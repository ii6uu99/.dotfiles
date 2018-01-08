#!/bin/sh
## Description: Install VNC (tigervnc-server)

## HOW TO USE (as root):
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/tigervnc-server.sh | sh /dev/stdin
## OR
# vncpassword=passw0rd sh -c 'curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/tigervnc-server.sh | sh /dev/stdin'


[ -z "$vncpassword" ] && vncpassword=''
[ -z "$USER" ] && export USER='user'
[ -z "$uid" ] && uid='1001'
[ -z "$gid" ] && gid='0'

[ -z "$sudoersgroup" ] && sudoersgroup=`cut -d: -f1 /etc/group | grep sudo | sort | head -1`
[ -z "$sudoersgroup" ] && sudoersgroup='wheel'

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     xorg-x11-utils xorg-x11-server-Xorg

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     x11-common x11-utils x11-session-utils x11-xserver-utils \
     xserver-xorg-core

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     xfonts-base xfonts-100dpi xfonts-75dpi xfonts-x3270-misc

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     xfonts-cyrillic t1-cyrillic

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     dejavu-sans-fonts dejavu-sans-mono-fonts dejavu-serif-fonts

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     fonts-dejavu-core

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     fonts-freefont-ttf

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     gnome-session xterm sudo mc

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     metacity

#curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
#     xfce4 xfce4-goodies

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     tigervnc-server

curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/posix-clean-update-install.sh | sh /dev/stdin \
     tightvncserver

dbus-uuidgen --ensure

export DISPLAY=":1"
export HOME=/home/${USER}

useradd -u ${uid} -r -g ${gid} -d ${HOME} -s /bin/bash ${USER} && \
passwd -d ${USER} && \
usermod -a -G ${sudoersgroup} ${USER} && \
[ ! -d ${HOME}/.vnc ] && mkdir -p ${HOME}/.vnc

/bin/echo -en '\x23!/bin/sh\n'"\
\n\
\x23 unset DBUS_SESSION_BUS_ADDRESS\n\
\n\
\x23# Run it before for clipboard support\n\
[ -x  /usr/bin/vncconfig ] && /usr/bin/vncconfig -iconic &\n\
\n\
\x23# Uncomment the following two lines for normal desktop:\n\
unset SESSION_MANAGER\n\
\x23 exec /etc/X11/xinit/xinitrc\n\
\n\
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup\n\
[ -r \$HOME/.Xresources ] && xrdb \$HOME/.Xresources\n\
\n\
[ -x /usr/bin/xsetroot ] && /usr/bin/xsetroot -solid '#222E45'\n\
[ -x /usr/bin/xclock ] && /usr/bin/xclock -geometry 100x100-5+5 &\n\
[ -x /usr/bin/xterm ] && xterm -geometry 132x44-10-10 -ls -title \"\$VNCDESKTOP Desktop\" &\n\
[ -x /usr/bin/metacity ] && /usr/bin/metacity &\n\
if test -z \"\$DBUS_SESSION_BUS_ADDRESS\" ; then\n\
	eval \`dbus-launch --sh-syntax --exit-with-session\`\n\
	echo \"D-BUS per-session daemon address is: \\n\
	\$DBUS_SESSION_BUS_ADDRESS\"\n\
fi\n\
\n\
\x23# Add your soft here: /path/to/file &\n\
\n\
exec sudo /usr/bin/gnome-session\n\
" > ${HOME}/.vnc/xstartup

/bin/echo "${vncpassword}" | vncpasswd -f > ${HOME}/.vnc/passwd

chown -R ${uid}:${gid} ${HOME} && \
chmod 600 ${HOME}/.vnc/passwd && \
chmod 775 ${HOME}/.vnc/xstartup

# RUN [ ! -d /mnt/docker-volume ] && mkdir /mnt/docker-volume
# VOLUME /mnt/docker-volume
# EXPOSE 5901
# LABEL io.openshift.expose-services="5901:tcp"
# USER ${USER}
## /usr/bin/vncserver -fg
