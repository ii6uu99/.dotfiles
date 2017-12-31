#https://github.com/lihaixin2/novnc

FROM lihaixin/cnsshd
MAINTAINER Haixin Lee <docker@lihaixin.name>
ENV VNC_PW "vncpassword"
ENV DISPLAY :0

#升级仓库，安装xvfb x11vnc fluxbox

RUN apt-get update -y &&  apt-get -y install xvfb x11vnc fluxbox xdotool  git git-core ca-certificates && \
    mkdir ~/.vnc && \
    touch ~/.vnc/passwd

#配置VNC密码
RUN x11vnc -storepasswd $VNC_PW ~/.vnc/passwd

# Clone noVNC, and set vnc_auto as homepage
RUN git clone --recursive https://github.com/kanaka/noVNC.git /opt/novnc && \
        git clone --recursive https://github.com/kanaka/websockify.git /opt/novnc/utils/websockify && \
        ln -s /opt/novnc/vnc.html /opt/novnc/index.html

# 升级到最新版本
RUN apt-get upgrade --yes

# 删除不必要的软件和Apt缓存包列表
RUN apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# Docker's supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose VNC port，5900为VNC客户端登录的端口，8787为novnc
EXPOSE 5900 8787



# Run Service

CMD ["/usr/bin/supervisord"]
