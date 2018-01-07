#!/bin/sh
docker run --detach --name ss \
	--volume /etc/shadowsocks/config2.json:/etc/config.json \
	--volume /etc/resolv.conf:/etc/resolv.conf \
	--volume /etc/hosts:/etc/hosts \
	-p 8084:8084 \
	ss-htc
