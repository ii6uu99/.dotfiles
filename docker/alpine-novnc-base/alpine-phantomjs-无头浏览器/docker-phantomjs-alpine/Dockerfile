FROM mhart/alpine-node:8

COPY fonts.tar.bz2 /tmp/fonts.tar.bz2

RUN mkdir -p /usr/share/fonts \
	&& tar -xjvf /tmp/fonts.tar.bz2 -C /usr/share/fonts \
	&& mkdir /tmp/phantomjs

RUN apk update \
	&& apk upgrade \
	&& apk add --no-cache curl ca-certificates openssl \
	&& apk add --update ca-certificates openssl \
	&& update-ca-certificates \
    && cd /tmp/phantomjs \
	&& curl -Ls https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz | tar xz \
	&& rm -rf /tmp/phantomjs/bin /tmp/phantomjs/etc /tmp/phantomjs/usr/bin \
	&& cp -rf /tmp/phantomjs/* / \
	&& ln -s /usr/local/bin/phantomjs /usr/bin/phantomjs \
	&& chmod 755 /usr/local/bin/phantomjs \
	&& chmod 755 /usr/bin/phantomjs \
	&& rm -rf /tmp/* /var/cache/apk/* \
	&& mkdir -p /root
