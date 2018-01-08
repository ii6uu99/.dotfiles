#! /bin/bash
# Program:
#     清理无名的docker镜像
# History:
#     2017/05/19 wcs217 release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

docker rmi $(docker images | grep '^<none>' | awk '{print $3}')

exit 0
