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

#tar cvf $tmpdir/pragmata.tar -C /usr/share/fonts/truetype/pragmata .

# use old infinality debs before the hinting regression https://github.com/achaphiv/ppa-fonts/issues/29
tar cvf $tmpdir/debs.tar -C ~/docker fontconfig-infinality_20130104-0ubuntu0ppa1_all.deb libfreetype6_2.6.1-0.1ubuntu2ppa1bohoomil20151108_amd64.deb

echo "FROM ubuntu:16.04

ADD debs.tar /
RUN apt-get update \\
 && apt-get -y upgrade \\
 && apt-get -y install libpng12-0 \\
 && dpkg -i fontconfig-infinality_20130104-0ubuntu0ppa1_all.deb libfreetype6_2.6.1-0.1ubuntu2ppa1bohoomil20151108_amd64.deb \\
 && perl -pi.old -e 's/false/true/ if /<edit name=.antialias./ ... /<.edit/' /etc/fonts/infinality/conf.src/50-base-rendering-win98.conf \\
 && perl -pi.old -e 's/<string>DejaVu Sans<.string>//g'                      /etc/fonts/infinality/conf.src/41-repl-os-win.conf \\
 && sed -i -r 's|USE_STYLE=\"DEFAULT\"|USE_STYLE=\"WINDOWS\"|g' /etc/profile.d/infinality-settings.sh \\
 && /etc/fonts/infinality/infctl.sh setstyle win98 \\
 && apt-get -y install fontconfig \\
 && fc-cache -f -v

#ADD pragmata.tar /usr/share/fonts/truetype/pragmata
#RUN apt-get -y install fontconfig \\
# && fc-cache -f -v

# https://github.com/nodesource/docker-node/blob/master/base/ubuntu/xenial/Dockerfile
RUN apt-get update \
 && apt-get install -y --force-yes --no-install-recommends \
      apt-utils \
      apt-transport-https \
      ssh-client \
      build-essential \
      curl \
      ca-certificates \
      git \
      libicu-dev \
      'libicu[0-9][0-9].*' \
      lsb-release \
      python-all \
      rlwrap

# https://github.com/nodesource/docker-node/blob/master/ubuntu/trusty/node/5.12.0/Dockerfile
RUN curl https://deb.nodesource.com/node_5.x/pool/main/n/nodejs/nodejs_5.12.0-1nodesource1~\$(lsb_release -cs)1_amd64.deb > node.deb \\
 && dpkg -i node.deb \\
 && rm node.deb

# for electron
RUN apt-get install -y libgtk2.0-dev libxtst6 libxss1 libgconf-2-4 libnss3 libasound2 libnotify4 dbus-x11 xdg-utils

RUN mkdir -p ${home} \\
 && chown ${uid}:${gid} -R ${home} \\
 && echo \"${user}:x:${uid}:${gid}:${user},,,:${home}:/bin/bash\" >> /etc/passwd \\
 && echo \"${user}:x:${uid}:\"                                    >> /etc/group \\
 && [ -d /etc/sudoers.d ] || (apt-get update && apt-get -y install sudo) \\
 && echo \"${user} ALL=(ALL) NOPASSWD: ALL\"                       > /etc/sudoers.d/${user} \\
 && chmod 0440 /etc/sudoers.d/${user}
USER ${user}
ENV HOME ${home}

CMD [ -f ~/vscode/scripts/code.sh ] || (cd ~; git clone https://github.com/microsoft/vscode; cd ~/vscode; ./scripts/npm.sh install --arch=x64) \\
 && cd $(escape_me "$(pwd)"); \\
    ~/vscode/scripts/code.sh $(escape_me "$@")

" > $tmpdir/Dockerfile

docker build -t $image $tmpdir
rm -rf $tmpdir

docker run -ti -e DISPLAY --net=host \
  -v $HOME/.Xauthority:${home}/.Xauthority:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /usr/share/fonts:/usr/share/fonts:ro \
  -v "$(pwd)":"$(pwd)" \
  -v ${home}/node_modules:${home}/node_modules:ro \
  -v ${home}/vscode:${home}/vscode \
  -v /opt:/opt:ro \
  -v /dev/dri:/dev/dri \
  -v /dev/snd:/dev/snd \
  --privileged \
  --memory=2000mb \
  --rm $image
