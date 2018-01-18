#!/usr/bin/env bash

# Old Firefox with JRE 6 for managing HP servers
# https://www.reddit.com/r/linuxquestions/comments/2oebqn/problems_using_ilo_java_interface_with_java_7_and/

image=$(basename $0 .sh)
user=${USER:-root}
home=${HOME:-/home/$user}
uid=${UID:-1000}
gid=${uid:-1000}
tmpdir=$(mktemp -d)

escape_me() {
  perl -e 'print(join(" ", map { my $x=$_; s/\\/\\\\/g; s/\"/\\\"/g; s/`/\\`/g; s/\$/\\\$/g; s/!/\"\x27!\x27\"/g; ($x ne $_) || /\s/ ? "\"$_\"" : $_ } @ARGV))' "$@"
}

echo "FROM ubuntu:10.04

RUN /bin/sed -i -r 's#archive#old-releases#g' /etc/apt/sources.list \\
 && apt-get update \\
 && apt-get -y install ia32-libs xterm wget

RUN wget --no-check-certificate --no-cookies --header 'Cookie: oraclelicense=accept-securebackup-cookie' \\
         http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jre-6u45-linux-i586.bin \\
 && bash jre-6u45-linux-i586.bin

RUN wget --no-check-certificate https://ftp.mozilla.org/pub/firefox/releases/3.6.3/linux-i686/en-US/firefox-3.6.3.tar.bz2 \\
 && tar xjvf firefox-3.6.3.tar.bz2 \\
 && mkdir -p /usr/lib/mozilla/plugins \\
 && ln -s /jre1.6.0_45/lib/i386/libnpjp2.so /usr/lib/mozilla/plugins

RUN mkdir -p ${home} \\
 && chown ${uid}:${gid} -R ${home} \\
 && echo \"${user}:x:${uid}:${gid}:${user},,,:${home}:/bin/bash\" >> /etc/passwd \\
 && echo \"${user}:x:${uid}:\"                                    >> /etc/group \\
 && [ -d /etc/sudoers.d ] || (apt-get update && apt-get -y install sudo) \\
 && echo \"${user} ALL=(ALL) NOPASSWD: ALL\"                       > /etc/sudoers.d/${user} \\
 && chmod 0440 /etc/sudoers.d/${user}
USER ${user}
ENV HOME ${home}

CMD /firefox/firefox --no-remote $(escape_me "$@")
" > $tmpdir/Dockerfile

docker build -t $image $tmpdir
rm -rf $tmpdir


# this may be run under Java's `Runtime.getRuntime.exec` or from XFCE menu, in this case no `docker -t` nor `docker -i` start
ti() {
  stty -a >/dev/null
  if [ $? -eq 0 ]; then echo "-ti"; fi
}

docker run $(ti) -e DISPLAY --net=host -v $HOME/.Xauthority:${home}/.Xauthority:ro -v /tmp/.X11-unix:/tmp/.X11-unix \
  --rm $image
