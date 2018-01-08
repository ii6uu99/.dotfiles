#! /bin/bash
# Program:
#     创建一个docker镜像
# History:
#     2017/05/19 wcs217 release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "Docker image name: " image_name

if [ "${docker-image-name}" != "" ]; then
    docker build -t ${image_name} .
    exit 0
fi
docker build .

exit 0
