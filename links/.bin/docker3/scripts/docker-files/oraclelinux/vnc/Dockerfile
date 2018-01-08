FROM oraclelinux:latest

RUN yum clean all && \
    yum -y update && \
    ( yum -y --setopt=tsflags=nodocs install which 2>/dev/null || true ) && \
    yum -y --setopt=tsflags=nodocs install curl && \
    yum clean all && \
    rm -rf /var/cache/yum/*

RUN curl -sjkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/install/tigervnc-server.sh | sh -x /dev/stdin

RUN mkdir /mnt/docker-volume
VOLUME /mnt/docker-volume

EXPOSE 5901 1521
LABEL io.openshift.expose-services="5901:tcp,1521:tcp"
# USER ${USER}
USER user
ENV USER=user HOME=/home/user DISPLAY=":1"
CMD []
ENTRYPOINT rm -rf /tmp/.X11-unix/* && \
           rm -rf /tmp/.X*-lock && \
           rm -rf /tmp/*.tmp && \
           /usr/bin/vncserver -geometry 1704x900 -fg
