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

# use old infinality debs before the hinting regression https://github.com/achaphiv/ppa-fonts/issues/29
tar cvf $tmpdir/debs.tar -C ~/docker fontconfig-infinality_20130104-0ubuntu0ppa1_all.deb

echo "FROM ubuntu:16.04

ADD debs.tar /
RUN apt-get update \\
 && apt-get -y upgrade \\
 && apt-get -y install libpng12-0 fontconfig \\
 && dpkg -i fontconfig-infinality_20130104-0ubuntu0ppa1_all.deb \\
 && perl -pi.old -e 's/false/true/ if /<edit name=.antialias./ ... /<.edit/' /etc/fonts/infinality/conf.src/50-base-rendering-win98.conf \\
 && perl -pi.old -e 's/<string>DejaVu Sans<.string>//g'                      /etc/fonts/infinality/conf.src/41-repl-os-win.conf \\
 && /etc/fonts/infinality/infctl.sh setstyle win98


RUN apt-get -y install wget libpango1.0-0 libxss1 fonts-liberation libappindicator1 libcurl3 xdg-utils libindicator7 libpangox-1.0-0 libpangoxft-1.0-0 gconf-service libasound2 libgconf-2-4 libnspr4 libnss3

RUN wget https://downloads.vivaldi.com/stable/vivaldi-stable_1.6.689.46-1_amd64.deb \\
 && dpkg -i vivaldi-*.deb \\
 && rm -f vivaldi-*.deb

RUN mkdir -p ${home} \\
 && chown ${uid}:${gid} -R ${home} \\
 && echo \"${user}:x:${uid}:${gid}:${user},,,:${home}:/bin/bash\" >> /etc/passwd \\
 && echo \"${user}:x:${uid}:\"                                    >> /etc/group \\
 && [ -d /etc/sudoers.d ] || (apt-get update && apt-get -y install sudo) \\
 && echo \"${user} ALL=(ALL) NOPASSWD: ALL\"                       > /etc/sudoers.d/${user} \\
 && chmod 0440 /etc/sudoers.d/${user}

USER ${user}
ENV HOME ${home}

CMD /usr/bin/vivaldi \
  --disable-smooth-scrolling \
  --user-data-dir=/tmp \
  --disable-notifications \
  --disable-sync \
  --disable-smooth-scrolling \
  --no-default-browser-check \
  --no-first-run \
  --disable-gpu \
  $(escape_me "$@")
" > $tmpdir/Dockerfile

docker build -t $image $tmpdir
rm -rf $tmpdir

# this may be run under Java's `Runtime.getRuntime.exec` or from XFCE menu, in this case no `docker -t` nor `docker -i` start
ti() {
  stty -a >/dev/null
  if [ $? -eq 0 ]; then echo "-ti"; fi
}

# start tmp session, firefox: second run will create a new tab in it; chrome: start second container
# X11 requires /root/.Xauthority, Xrdp requires /tmp/X11-unix
#docker run $(ti) -e DISPLAY --net=host -v $HOME/.Xauthority:${home}/.Xauthority:ro -v /tmp/.X11-unix:/tmp/.X11-unix \
#  --memory=1000mb \
#  --rm $image

# multimedia
docker run $(ti) -e DISPLAY --net=host -v $HOME/.Xauthority:${home}/.Xauthority:ro -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /home/user/Downloads:/home/user/Downloads \
  -v /dev/dri:/dev/dri \
  -v /dev/snd:/dev/snd \
  --privileged \
  --rm $image

#  --memory=4000mb

# start new session every time, the state is preserved upon chrome exit and can be resumed by 'docker start <some_random_name>';
#docker run $(ti) -e DISPLAY --net=host -v $HOME/.Xauthority:${home}/.Xauthority:ro -v /tmp/.X11-unix:/tmp/.X11-unix \
#  $image

# start named session, which can be resumed by 'docker start nameff'; second start would fail
#docker run $(ti) -e DISPLAY --net=host -v $HOME/.Xauthority:${home}/.Xauthority:ro -v /tmp/.X11-unix:/tmp/.X11-unix \
#  --name nameff $image
