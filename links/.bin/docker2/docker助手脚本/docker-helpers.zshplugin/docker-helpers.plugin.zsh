
  alias d='docker'
  alias dkd='docker run -d -P'
  alias dki='docker run -t -i -P'
  alias dkl='docker ps -l -q'
  alias docker-daemonize='docker run -d -P'
  alias docker-interactive='docker run -t -i -P'
  alias docker-last='docker ps -l -q'
  alias dockerbuild='docker build'
  alias dockerimages='docker images'
  alias dockerps='docker ps'

  d-ip() {
    docker inspect --format "{{ .NetworkSettings.IPAddress }}" $1
  }

  dkb() {
    docker build -t="$1" .
  }

  d-grep() {
    docker ps | grep $@ | grep -v ^CONTAINER
  }

  d-kill-pattern() {
    docker ps \
      | grep $@ \
      | grep -v ^CONTAINER \
      | awk '{print $1}' \
      | xargs -rI % bash -c 'echo $(docker kill %; echo "killed!");'
  }

  d-pid() {
    docker inspect --format "{{ .State.Pid }}" $1
  }

  d-purge() {
    docker rm $(docker ps -a -q);
  }

  d-stats() {
    docker ps -q | xargs docker stats
  }

  d-stop() {
    # Stop all running containers
    docker stop $(docker ps -a -q);
  }

  d-zsh() {
    local TAG=$1
    docker run -v /tmp:/host_tmp:rw -i -t $TAG /bin/zsh
  }

  dps-monitor() {
     while true
     do
         clear
         docker ps | cut -c -$(tput cols)
         sleep 0.5
     done
  }

  # helpers for starting a container with access to the current directory

  d-busybox() {
    docker run -v $(pwd):/shared --rm -it busybox:latest /bin/sh
  }

  d-centos() {
    docker run -v $(pwd):/shared --rm -it centos:centos7 /bin/bash
  }

  d-centos6() {
    docker run -v $(pwd):/shared --rm -it centos:centos6 /bin/bash
  }

  d-fedora() {
    docker run -v $(pwd):/shared --rm -it fedora:20 /bin/bash
  }

  d-ubuntu() {
    docker run -v $(pwd):/shared --rm -it ubuntu:14.04 /bin/bash
  }
fi

if (which docker-compose > /dev/null)
then
  alias d-cp=docker-compose
fi
