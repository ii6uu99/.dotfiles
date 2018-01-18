FROM andrewkrug/kali-linux-docker:rolling
MAINTAINER andrewkrug@gmail.com

RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list
RUN echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y dist-upgrade

#安装Kali Linux十大软件包
RUN apt-get install kali-linux-top10 -y

WORKDIR /

#实际上安装实际包含在最新的滚动kali中的Mate :)
RUN apt-get --yes --allow-downgrades --allow-remove-essential --quiet --allow-unauthenticated install mate-core

#安装xspice-server
RUN apt-get install xserver-xspice -y

RUN apt-get install spice-vdagent -y

RUN apt-get install xserver-xorg-video-qxl -y

#复制配置
RUN mkdir -p /etc/spice-server-config
COPY ./spiceqxl.xorg.conf /etc/spice-server-config/spiceqxl.xorg.conf

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
