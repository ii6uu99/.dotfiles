FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

#安装进程管理supervisor
RUN apt-get update -y && \
    apt-get install -y supervisor && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/supervisord", "-n"]

#------------------------------

#安装xrdp
RUN apt-get update -y && \
    apt-get install -y xrdp && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -ms /bin/bash desktop && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto && \
    echo "ming:ming" | chpasswd

ADD xrdp.conf /etc/supervisor/conf.d/xrdp.conf

EXPOSE 3389
