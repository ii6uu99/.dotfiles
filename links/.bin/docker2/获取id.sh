#!/bin/bash

# 抓取当前用户的uid和gid信息
USER_ID=$(id -u)
GROUP_ID=$(id -g)
GROUP=$(id -ng)
DOCKER_GID=

# 设置显示
if [ "$(uname)" == "Darwin" ]; then
    ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
    xhost + $ip
    xsession="-e DISPLAY=$ip:0 -v /tmp/.X11-unix:/tmp/.X11-unix"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    DOCKER_GID=$(cut -d: -f3 < <(getent group docker))

    # 如果我们没有映射$ HOME：$ HOME，我们至少需要
    # map the XAUTHORITY 映射信息
    #           -e XAUTHORITY=/tmp/.Xauthority \
    #           -v $HOME/.Xauthority:/tmp/.Xauthority \
    xsession="-e DISPLAY \
              -v /tmp/.X11-unix:/tmp/.X11-unix"
else
    echo "Unsupported Platform: " $(uname)
    exit 1
fi

# ＃运行容器的配置示例，以用户身份映射
#＃以及他们的主目录，允许他们运行X应用程序
# docker, without requring sudo

docker run --rm \
    -it \
    $xsession \
    --net=host \
    --workdir=$(pwd) \
    -e USER=$USER \
    -e USER_ID=$USER_ID \
    -e GROUP=$GROUP \
    -e GROUP_ID=$GROUP_ID \
    -e DOCKER_GID=$DOCKER_GID \
    -v $HOME:$HOME \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /etc/localtime:/etc/localtime:ro \
    core3d/core3d:latest \
    "$@"

#    dtr.research.ge.com/200003581/ge-ubuntu17.04:latest \
