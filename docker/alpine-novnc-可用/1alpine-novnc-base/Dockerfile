#alpine novnc 基础镜像，需要扩展
#https://github.com/jbbodart/alpine-novnc-docker

FROM alpine:edge

RUN \
    # 安装所需的软件包
    echo "http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk --update --upgrade add \
      bash \
      fluxbox \
      git \
      supervisor \
      xvfb \
      x11vnc \
      && \
    # 安装noVNC
    git clone --depth 1 https://github.com/novnc/noVNC.git /root/noVNC && \
    git clone --depth 1 https://github.com/novnc/websockify /root/noVNC/utils/websockify && \
    rm -rf /root/noVNC/.git && \
    rm -rf /root/noVNC/utils/websockify/.git && \
    apk del git && \
    sed -i -- "s/ps -p/ps -o pid | grep/g" /root/noVNC/utils/launch.sh

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8080

#设置环境变量
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1280 \
    DISPLAY_HEIGHT=720

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
