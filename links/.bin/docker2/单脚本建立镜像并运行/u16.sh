#!/usr/bin/env bash

image=$(basename $0 .sh)
user=${USER:-root}
home=${HOME:-/home/$user}
uid=${UID:-1000}
gid=${uid:-1000}
tmpdir=$(mktemp -d)

escape_me() {
  perl -e 'print(join(" ", map { my $x=$_; s/\\/\\\\/g; s/\"/\\\"/g; s/`/\\`/g; s/\$/\\\$/g; s/!/\"\x27!\x27\"/g; ($x ne $_) || /\s/ ? "\"$_\"" : $_ } @ARGV))' "$@"
}

echo "FROM ubuntu:16.04

RUN apt-get update \\
 && apt-get -y install apt-utils perl libwww-perl wget curl git mercurial build-essential scons protobuf-compiler libprotobuf-dev

RUN mkdir -p ${home} \\
 && chown ${uid}:${gid} -R ${home} \\
 && echo \"${user}:x:${uid}:${gid}:${user},,,:${home}:/bin/bash\" >> /etc/passwd \\
 && echo \"${user}:x:${uid}:\"                                    >> /etc/group \\
 && [ -d /etc/sudoers.d ] || (apt-get update && apt-get -y install sudo) \\
 && echo \"${user} ALL=(ALL) NOPASSWD: ALL\"                       > /etc/sudoers.d/${user} \\
 && chmod 0440 /etc/sudoers.d/${user}
USER ${user}
ENV HOME ${home}

CMD cd $(escape_me "$(pwd)"); \\
    $(escape_me "$@")
" > $tmpdir/Dockerfile

docker build -t $image $tmpdir
rm -rf $tmpdir

docker run -ti -e DISPLAY --net=host \
  -v $HOME/.Xauthority:${home}/.Xauthority:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$(pwd)":"$(pwd)" \
  -v ${home}/.m2:${home}/.m2 \
  -v /opt:/opt:ro \
  -v /dev/dri:/dev/dri \
  -v /dev/snd:/dev/snd \
  --privileged \
  --memory=4000mb \
  --rm $image
