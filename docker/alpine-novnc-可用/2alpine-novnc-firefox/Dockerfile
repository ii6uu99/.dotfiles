#https://hub.docker.com/r/jbbodart/alpine-novnc-firefox/
# alpine-novnc  https://hub.docker.com/r/jbbodart/alpine-novnc/
# https://github.com/jbbodart/alpine-novnc-docker 

FROM jbbodart/alpine-novnc
RUN \
    # Install firefox
    apk --update --no-cache add dbus xterm firefox-esr fontconfig ttf-freefont && \
    rm  -rf /tmp/* /var/cache/apk/* && \
    mkdir /root/.mozilla && \
    mkdir /root/Downloads && \
    cd /etc/supervisor/conf.d && \
    # Append firefox entry to supervisord.conf
    echo '[program:firefox]' >> supervisord.conf && \
    echo "command=bash -c 'sleep 5 && /usr/bin/firefox --no-remote'" >> supervisord.conf && \
    echo 'autorestart=true' >> supervisord.conf

VOLUME /root/.mozilla
VOLUME /root/Downloads
