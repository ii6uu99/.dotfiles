#!/bin/bash

set -e

IMAGE="php:5.6-cli"


# 设置挂载点
if [ "$(pwd)" != '/' ]; then
    VOLUMES="-v $(pwd):$(pwd)"
else
    echo "don't use root (/) dir for executing this"
    exit 1
fi

# 只有分配tty才能检测到
if [ -t 1 ]; then
    RUN_OPTIONS="-t"
fi
if [ -t 0 ]; then
    RUN_OPTIONS="$RUN_OPTIONS -i"
fi
#在当前文件夹运行镜像
exec docker run --user=$UID --rm $RUN_OPTIONS $VOLUMES -w "$(pwd)" $IMAGE php "$@"
