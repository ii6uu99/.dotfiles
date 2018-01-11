# ubuntu-lxde-tigervnc desktop

FROM  ubuntu:14.04
MAINTAINER akyshr "akyshr@gmail.com"

# 设置非交互
ENV DEBIAN_FRONTEND noninteractive

#确保包库是最新的
RUN apt-get update

# 安装sshd
RUN apt-get install -y openssh-server

# 安装应用程序。
RUN apt-get install -y firefox

RUN apt-get install -y xserver-xorg fonts-takao-gothic fonts-takao-mincho fonts-takao-pgothic

# Fake a fuse install
RUN apt-get install libfuse2
RUN cd /tmp ; apt-get download fuse
RUN cd /tmp ; dpkg-deb -x fuse_* .
RUN cd /tmp ; dpkg-deb -e fuse_*
RUN cd /tmp ; rm fuse_*.deb
RUN cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst
RUN cd /tmp ; dpkg-deb -b . /fuse.deb
RUN cd /tmp ; dpkg -i /fuse.deb
RUN rm -fr /tmp ; mkdir /tmp ; chmod 5777 /tmp
#RUN apt-get install -y fuse



RUN apt-get install -y lxde 
RUN apt-get install -y scim-anthy


# 设置语言环境（修复语言环境警告）
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

RUN dpkg -r lxdm
RUN apt-get install -y xdm

# 将文件复制到容器中
ADD . /src
RUN rm /src/*~ ; true
RUN chown -R root.root /src

# 安装tigervnc
RUN dpkg -i /src/packages/*.deb

#设置SSH
RUN mkdir /var/run/sshd

RUN echo ":0 local /usr/bin/Xtigervnc :0 -geometry 1280x768 -depth 24 -desktop vnc -SecurityTypes None -nolisten tcp" > /etc/X11/xdm/Xservers

EXPOSE 22
EXPOSE 5900

# 启动XDM和SSH服务。
CMD ["/bin/bash", "/src/startup.sh"]
