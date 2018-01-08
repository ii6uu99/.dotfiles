#! /bin/bash
# Program:
#     恢复数据库到容器
# History:
#     2017/05/22 wcs217 release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "Container name: " container_name
read -p "DB name: " db_name
read -p "Password: " db_password

cat backup.sql | docker exec -i ${container_name} /usr/bin/mysql -u root --password=${db_password} ${db_name}

exit 0
