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



