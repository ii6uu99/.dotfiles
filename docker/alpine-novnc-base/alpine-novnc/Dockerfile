# alpine linux novnc
#来源 https://github.com/youske/alpine-novnc


#FROM alpine:edge
FROM ii6uu99/alpine-base
MAINTAINER youske miyakoshi <youske@gmail.com>

#设置环境变量
ENV HOME=/root
ENV PORT=8080

#设置尺寸
ENV DISPLAYSIZE=${XDISPLAY_WIDTH}"x"${XDISPLAY_WIDTH}"x"${XDISPLAY_DEPTH}
ENV DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768

#自动化安装
ENV DEBIAN_FRONTEND=noninteractive

#语言设置
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8
#时区设置，先安装tzdata
ENV TZ=Asia/Shanghai

RUN echo "http://mirrors.aliyun.com/alpine/edge/main/"> /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/edge/community/" >> /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/edge/testing/" >> /etc/apk/repositories && \
PACKAGE="wget ca-certificates git bash xvfb x11vnc fluxbox net-tools supervisor xterm " && \
apk update upgrade --no-cache && apk add --no-cache ${PACKAGE}


RUN apk --update add tzdata --no-cache && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && echo $TZ > /etc/timezone && \
    apk del tzdata

RUN apk --update --upgrade add \
      bash \  
      fluxbox \
      git \
      supervisor \
      xvfb \
      xterm \
      x11vnc \
      wget \
      ca-certificates \
      git \
      net-tools \
      && \
    # 安装noVNC
    git clone https://github.com/kanaka/noVNC.git /opt/noVNC && \
    git clone https://github.com/kanaka/websockify /opt/websockify && \
    ln -sf /opt/websockify /opt/noVNC/utils/websockify && \
    ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html && \
    rm -rf /opt/noVNC/.git && \
    rm -rf /opt/websockify/.git

# 安装chromium浏览器
#RUN apt-get install -y chromium-browser
#RUN sed -i -- "s/ps -p/ps -o pid | grep/g" /opt/noVNC/utils/launch.sh

# Configure & run supervisor
EXPOSE ${PORT} 6000
COPY novnc.conf /etc/supervisor/conf.d/novnc.conf
ENTRYPOINT ["switch","shell=/bin/bash","--","/init"]
#ENTRYPOINT ["render","/etc/supervisor/conf.d/novnc.conf","--","switch","shell=/bin/bash","--","/init"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/novnc.conf"]
