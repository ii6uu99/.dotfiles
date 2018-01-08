#! /bin/bash
# Program:
#     创建一个docker容器
# History:
#     2017/05/19 wcs217 release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "Image name: " image_name
read -p "Container name: " container_name
read -p "Port: " port

docker run -d -p ${port}:${port} --name ${container_name} ${image_name}

exit 0
