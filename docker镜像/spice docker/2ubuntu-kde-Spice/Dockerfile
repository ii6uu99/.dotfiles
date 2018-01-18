from        ubuntu:16.04
MAINTAINER Don Bowman <db@donbowman.ca>
ENV DEBIAN_FRONTEND=noninteractive

ENV LANG en_CA.UTF-8


RUN        \
           apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E6D4736255751E5D && \
           echo deb http://archive.neon.kde.org/user/ xenial main > /etc/apt/sources.list.d/kde.list && \
           echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
           wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
           apt update && \
           apt -y install software-properties-common && \
           add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ xenial universe multiverse" && \
           add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates universe multiverse" && \
           apt update && \
           apt -y install xserver-xspice \
                              x11-xserver-utils \
                              neon-desktop \
                              plasma-desktop \
                              ttf-mscorefonts-installer \
                              spice-vdagent \
                              sudo \
                              rxvt-unicode && \
           dpkg -r bluedevil && \
           dpkg -r powerdevil && \
           rm -f /etc/xdg/autostart/baloo_file.desktop
ADD	   spiceqxl.xorg.conf /etc/X11/
#ADD	   resolution.desktop /etc/xdg/autostart/
ADD	   keyboard.desktop /etc/xdg/autostart/
ADD 	   run.sh	/root/
ADD        kwinrc /root/
VOLUME	   ["/home"]
EXPOSE     5900
CMD        ["/root/run.sh"]

