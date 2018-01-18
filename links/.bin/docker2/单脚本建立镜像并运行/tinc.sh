#!/usr/bin/env bash

image=$(basename $0 .sh)
user=${USER:-root}
home=${HOME:-/home/$user}
uid=${UID:-1000}
gid=${uid:-1000}
tmpdir=$(mktemp -d)

echo "FROM ubuntu:16.04

RUN apt-get update && apt-get -y install iputils-ping net-tools mtr-tiny tinc

CMD (nohup tincd -d3 -D -n dmz &); (nohup tincd -d3 -D -n lan &); /bin/bash
" > $tmpdir/Dockerfile

docker build -t $image $tmpdir
rm -rf $tmpdir

docker run -ti -e DISPLAY --net=host -v $HOME/.Xauthority:${home}/.Xauthority:ro -v /tmp/.X11-unix:/tmp/.X11-unix \
  --cap-add=NET_ADMIN \
  --device /dev/net/tun:/dev/net/tun \
  -v /etc/tinc:/etc/tinc:ro \
  --rm $image

