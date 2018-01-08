#!/bin/bash

#https://github.com/gatorv/docker-scripts
# Script to create a MySQL image with a phpMyAdmin image

# 用法
function usage() {
    echo "Usage: $0 image_name mysql_password path_to_data host_mysql_port host_admin_port"
    exit 1
}

if [ $# -lt 5 ] ; then
    usage
    exit 1
fi

# 变量
MYSQL_NAME="$1_mysql"
MYSQL_PASSWORD=$2
DB_PATH=$3
HOST_PORT=$4
PHPMYADMIN_PORT=$5
FULL_PATH=$(readlink -f $DB_PATH)
PHPMYADMIN_NAME="$1_admin"
NETWORK_NAME="$1_network"

# 创建一个网络
docker network create ${NETWORK_NAME}
sleep 2

# 创建一个MySQL泊坞窗图片
docker run \
    --detach \
    --name=${MYSQL_NAME} \
    --env MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD} \
    --publish ${HOST_PORT}:3306 \
    --net=${NETWORK_NAME} \
    --volume=${FULL_PATH}:/var/lib/mysql \
    mysql:5.7;

sleep 2
# 创建一个phpMyAdmin泊坞窗图片
docker run \
    --detach \
    --name=${PHPMYADMIN_NAME} \
    --net=${NETWORK_NAME} \
    --publish ${PHPMYADMIN_PORT}:80 \
    --env PMA_HOST=${MYSQL_NAME} \
    phpmyadmin/phpmyadmin;

echo "Containers created use docker start/stop ${MYSQL_NAME} and/or docker start/stop ${PHPMYADMIN_NAME} to manipulate them"
