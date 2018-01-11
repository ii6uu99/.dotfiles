FROM ubuntu:latest
MAINTAINER Shrek Is Love <github.com/ShrekIsLoveLife>

ENV DEBIAN_FRONTEND noninteractive

# built-in packages
RUN apt-get update -o APT::Get::List-Cleanup=false
# RUN apt-get update
RUN apt-get -y --no-install-recommends install  python-software-properties software-properties-common
# firefox-esr ppa
RUN add-apt-repository ppa:mozillateam/ppa
# enlightment ppa
RUN add-apt-repository ppa:niko2040/e19
# RUN apt-get update
# I hate having to run this twice
RUN apt-get update -o APT::Get::List-Cleanup=false -o Dir::Etc::sourcelist=/etc/apt/sources.list.d/

RUN apt-get -y upgrade


RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
  curl \
  iputils-ping \
  less \
  supervisor \
  pwgen sudo vim-tiny \
  net-tools \
  enlightenment terminology \
  nginx \
  wget aria2 \
  git \
  openssl \
  python-pip python-dev build-essential \
  dbus-x11 x11-utils \
  libtasn1-3-bin \
  libglu1-mesa \
  xorg \
  firefox-esr \
  locales

RUN locale-gen en_US en_US.UTF-8

# RUN apt-get remove --purge --yes --auto-remove xterm

# tini for subreap                                   
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

RUN rm /etc/vim/vimrc.tiny && ln -s /etc/vim/vimrc /etc/vim/vimrc.tiny

# just because the ppa is soo slow to dl
# RUN apt-get install -y --no-install-recommends --allow-unauthenticated /root/firefox-esr_52.5.0esr+build2-0ubuntu0.16.04.1_amd64.deb
# RUN rm /root/firefox-esr_52.5.0esr+build2-0ubuntu0.16.04.1_amd64.deb

# Clone noVNC from github
RUN git clone  --branch stable/v0.6 --recursive https://github.com/novnc/noVNC.git /usr/lib/noVNC && \
    git clone --recursive https://github.com/novnc/websockify /usr/lib/noVNC/utils/websockify && \
    rm -rf /usr/lib/noVNC/.git && \
    rm -rf /usr/lib/noVNC/utils/websockify/.git
RUN sed -i -- "s/ps -p/ps -o pid | grep/g" /usr/lib/noVNC/utils/launch.sh

ADD https://dl.bintray.com/tigervnc/stable/ubuntu-16.04LTS/amd64/tigervncserver_1.8.0-1ubuntu1_amd64.deb /root/
RUN dpkg -i /root/tigervncserver_1.8.0-1ubuntu1_amd64.deb
RUN apt-get -f install
RUN rm /root/tigervncserver_1.8.0-1ubuntu1_amd64.deb

RUN pip install --upgrade pip
RUN pip install setuptools wheel numpy

ADD usr_lib_web_requirements.txt /usr/lib/web/requirements.txt
RUN pip install -r /usr/lib/web/requirements.txt
RUN rm -rf /usr/lib/web/requirements.txt

RUN apt-get autoclean
RUN apt-get autoremove
RUN rm -rf /var/lib/apt/lists/*

# https://wiki.ubuntu.com/ReducingDiskFootprint
RUN find /usr/share/locale -mindepth 1 -maxdepth 1 ! -name 'en' ! -name 'de*' !  -name 'es*' ! -name 'ja*' ! -name 'fr*' ! -name 'zh*' | xargs rm -r
RUN find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true
RUN find /usr/share/doc -empty|xargs rmdir || true
RUN rm -rf /usr/share/man /usr/share/groff /usr/share/info /usr/share/lintian /usr/share/linda /var/cache/man

RUN useradd --shell /bin/bash --user-group user -G sudo

EXPOSE 80
EXPOSE 443

WORKDIR /root
ENV HOME=/home/user \
    SHELL=/bin/bash

# ENTRYPOINT ["/startup.sh"]
