FROM x11docker/deepin

ADD source.sh /

RUN chmod +x source.sh &&\
    sh source.sh
RUN \
#更新系统和升级系统
apt-get update -y &&\
apt-get upgrade -yy &&\
apt-get -y install lxterminal xrdp


ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get -q -y update \
 && apt-get -q -y install runit \
                          rsyslog \
                          wget \
                          python \
                          python-numpy \
                          \
                          openssh-server \
                          tigervnc-standalone-server \
                          \
                          #mate-desktop-environment \
                          tmux \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list \
 \
 && echo ">> rsyslog" \
 && head -n $(grep -n RULES /etc/rsyslog.conf | cut -d':' -f1) /etc/rsyslog.conf > /etc/rsyslog.conf.new \
 && mv /etc/rsyslog.conf.new /etc/rsyslog.conf \
 && echo '*.*        /dev/stdout' >> /etc/rsyslog.conf \
 && sed -i '/.*imklog*/d' /etc/rsyslog.conf \
 \
 && echo ">> NoVNC" \
 && wget https://github.com/novnc/noVNC/archive/v0.6.2.tar.gz -O /novnc.tar.gz \
 && tar xvf /novnc.tar.gz \
 && mv /noVNC* /opt/novnc \
 && cp /opt/novnc/vnc_auto.html /opt/novnc/index.html \
 \
 && echo ">> Websockify" \
 && wget https://github.com/novnc/websockify/archive/v0.8.0.tar.gz -O /websockify.tar.gz \
 && tar xvf /websockify.tar.gz \
 && mv /websockify-* /opt/websockify \
 \
 && echo ">> SSHD" \
 && mkdir -p /var/run/sshd \
 && echo "X11UseLocalhost no" >> /etc/ssh/sshd_config \
 && sed -i 's,^.*PermitEmptyPasswords .*,PermitEmptyPasswords yes,' /etc/ssh/sshd_config \
 && sed -i '1iauth sufficient pam_permit.so' /etc/pam.d/sshd

ADD scripts /opt/scripts

RUN chmod u+x /opt/scripts/entrypoint.sh

RUN useradd -ms /usr/local/bin/app-sh.sh app \
 && su -l -s /bin/sh -c "mkdir -p ~/.config/autostart ~/Desktop" app

VOLUME ["/config"]

EXPOSE 5901 80 443 22

ENTRYPOINT ["/opt/scripts/entrypoint.sh"]

#CMD bash /scripts/entrypoint.sh
