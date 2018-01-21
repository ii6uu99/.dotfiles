#获取cron的状态
alias crons=“sudo /usr/sbin/service cron status”

# 获取容器的状态
alias dps="docker ps"

# 获取所有容器的状态，包括停掉的
alias dpa="docker ps -a"

# 获取镜像
alias di="docker images"

# 获取容器ip
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# 运行交互式容器，例如, $dki base /bin/bash
alias dki="docker run -i -t -P"

# 执行交互式容器，例如, $dex base /bin/bash
alias dex="docker exec -i -t"

# 停止和移除所有容器
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# 停止所有容器
dstop() { docker stop $(docker ps -a -q); }

# 移除所有容器
drm() { docker rm $(docker ps -a -q); }

# 移除所有镜像
dri() { docker rmi $(docker images -q); }

#创建dockerfile, $dbu tcnksm/test
dbu() { docker build -t=$1 .; }

# 显示所有与docker相关的别名
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# 进入容器的bash
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

＃获取最新的容器ID
alias dl="docker ps -l -q"

＃获取容器进程
alias dps="docker ps"

＃获取进程包括停止容器
alias dpa="docker ps -a"

＃获取镜像
alias di="docker images"

＃获取容器IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

＃运行deamonized容器，例如$ dkd base / bin / echo hello
alias dkd="docker run -d -P"


＃运行交互容器，例如$ dki base / bin / bash
alias dki="docker run -i -t -P"


＃执行交互容器，例如$ dex base / bin / bash
alias dex="docker exec -i -t"

＃停止所有容器
dstop() { docker stop $(docker ps -a -q); }

＃删除所有容器
drm() { docker rm $(docker ps -a -q); }

#＃停止并删除所有容器
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'


＃删除所有图像
dri() { docker rmi $(docker images -q); }

＃构建Dockerfile，例如$ dbu tcnksm / test
dbu() { docker build -t=$1 .; }

＃显示所有别名相关的docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

＃进入正在运行的容器的bash
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

# Docker aliases
#

d-help() { declare -F | grep d- | cut -d " " -f 3; }

# ＃删除退出的容器
d-rm-ec() {
    EXITED_CONTAINERS=$(docker ps -a | grep Exited | cut -d " " -f 1;);
    if [ -z $EXITED_CONTAINERS ];
    then
        echo "No exited containers";
    else
        docker rm $EXITED_CONTAINERS;
    fi
}

#删除没有图像
d-rm-ni() {
    NONE_IMAGES=$(docker images | grep "^<none>" | awk '{print $3}' )
    if [ -z $NONE_IMAGES ];
    then
        echo "No none images";
    else
        docker rmi $NONE_IMAGES;
    fi
}

# 删除退出的容器和没有图像
d-rm-ci() { d-rm-ec && d-rm-ni; }

# 删除镜像
d-rm-i() { docker rmi $@; }

# 获取容器的IP地址
d-ip() { docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1; }

# 获取容器镜像
d-im() { docker images; }

d-im-s() { docker images | grep -v REPOSITORY | awk -F " " '{print $1":"$2}' | sort;}

# 获取所有的容器进程
d-ps-a() { docker ps -a; }

#运行交互容器
d-run-i() { docker run -ti --rm $@; }

#执行交互容器
d-ex-i() { docker exec -ti $@; }


# DOCKER
#--------------------------------------------------------------------------------
# 用于将UID和GID传递给“docker”或“docker-compose”的变量。
export HOST_USER_UID=`id -u`
export HOST_USER_GID=`id -g`

# 作为`root`用户在当前目录内运行一个临时容器。
alias docker-root-here='docker run --rm -it -v "$PWD":/work -w /work'

# 作为当前用户在当前目录中运行一个临时容器。
alias docker-here='docker-root-here -u `id -u`:`id -g`'

# 为了开发目的运行具有提升特权的临时容器。
alias docker-hack-here='docker-root-here --security-opt seccomp=unconfined'

# 以当前用户的身份在容器中执行命令。
alias docker-exec='docker exec -it -u `id -u`:`id -g`'

# Tails the container `STDOUT`.
alias docker-tail='docker logs -f --tail=100'











