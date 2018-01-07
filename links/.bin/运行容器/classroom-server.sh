#!/bin/sh
docker pull code.fdu13ss.org/classroom-server
docker run --detach \
	--publish 10010:10010 \
	--name classroom-server \
	--restart always \
	code.fdu13ss.org/classroom-server
