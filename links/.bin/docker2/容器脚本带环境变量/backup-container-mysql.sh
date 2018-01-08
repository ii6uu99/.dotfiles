#! /bin/bash
# Program:
#      从docker容器备份数据库
# History:
#     2017/05/22 wcs217 release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "Container name: " container_name
read -p "DB name: " db_name
read -p "Password: " db_password

docker exec ${container_name} /usr/bin/mysqldump -uroot --password=${db_password} ${db_name} > backup.sql

exit 0
