#!/usr/bin/env bash

image=$(basename $0 .sh)
user=${USER:-root}
home=${HOME:-/home/$user}
uid=${UID:-1000}
gid=${uid:-1000}
tmpdir=$(mktemp -d)

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

RUN apt-get -y install xterm wget \\
 && wget https://download.jetbrains.com/idea/ideaIC-2016.2.1.tar.gz \\
 && tar xzvf ideaIC-2016.2.1.tar.gz \\
 && rm ideaIC-2016.2.1.tar.gz

RUN mkdir -p ${home} \\
 && chown ${uid}:${gid} -R ${home} \\
 && echo \"${user}:x:${uid}:${gid}:${user},,,:${home}:/bin/bash\" >> /etc/passwd \\
 && echo \"${user}:x:${uid}:\"                                    >> /etc/group \\
 && [ -d /etc/sudoers.d ] || (apt-get update && apt-get -y install sudo) \\
 && echo \"${user} ALL=(ALL) NOPASSWD: ALL\"                       > /etc/sudoers.d/${user} \\
 && chmod 0440 /etc/sudoers.d/${user}
USER ${user}
ENV HOME ${home}

#CMD /usr/bin/xterm
CMD /idea-*/bin/idea.sh
" > $tmpdir/Dockerfile

docker build -t $image $tmpdir
rm -rf $tmpdir

# this may be run under Java's `Runtime.getRuntime.exec` or from XFCE menu, in this case no `docker -t` nor `docker -i` start
ti() {
  stty -a >/dev/null
  if [ $? -eq 0 ]; then echo "-ti"; fi
}

docker run $(ti) -e DISPLAY --net=host -v $HOME/.Xauthority:${home}/.Xauthority:ro -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /usr/share/fonts:/usr/share/fonts:ro \
  --memory=2000mb \
  --rm $image
