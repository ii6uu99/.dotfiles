#! /bin/bash
# Program:
#     停止所有容器
# History:
#     2017/05/19 wcs217 release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

docker stop $(docker ps -a -q)

exit 0






