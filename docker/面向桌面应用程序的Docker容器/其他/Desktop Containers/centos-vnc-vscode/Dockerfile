#
#
FROM appsoa/docker-centos-desktop-vnc:latest
MAINTAINER Matthew Davis <matthew@appsoa.io>

USER root
ENV TZ=$CONF_TIMEZONE

COPY src/home /home/
COPY src/entrypoint.sh /
COPY src/entrypoint.d/* /entrypoint.d/
ONBUILD COPY src/entrypoint.d/* /entrypoint.d/
RUN ls -la /home/user
RUN yum --enablerepo=epel -y -x gnome-keyring --skip-broken groups install "Xfce" && \
    yum -y clean all && \
    yum -y install /tmp/vscode.rpm \
                    nc telnet nmap tcpdump \
                    roboto-fontface-fonts \
                    google-noto-sans-fonts && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    wget -O /tmp/vscode.rpm https://go.microsoft.com/fwlink/?LinkID=760866 && \
    rm -rf /tmp/vscode.rpm && \
    chown -R user.wheel /home
RUN ls -la /home/user

RUN chown -R user.wheel /home
USER user

EXPOSE 5901

ENTRYPOINT ["/entrypoint.sh"]