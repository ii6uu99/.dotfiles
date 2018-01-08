#!/bin/sh

#创建名称文件
NAME_FILE=backup-$(date "+%b_%d_%Y_%H.%M.%S").zip

# 变量
STORAGE=/opt/storage  #选择存储
TO_BACKUP=/opt/backups #选择备份
TO_BACKUP_SAFE=/opt/backups-safe #选择安全备份

# 递归压缩
zip -r $TO_BACKUP/$NAME_FILE $STORAGE/

# 设置权限
chmod +x $TO_BACKUP/$NAME_FILE
chmod +x $TO_BACKUP_SAFE/$NAME_FILE

# 复制到备份安全的文件夹
cp $TO_BACKUP/$NAME_FILE $TO_BACKUP_SAFE

# -mtime +15 // 天
# -mmin +5 // 分钟
# find $TO_BACKUP -mtime +15 -exec rm -rf  "{}" \;
# find $TO_BACKUP_SAFE -mtime +15 -exec rm -rf  "{}" \;

find $TO_BACKUP -mmin +2 -exec rm -rf  "{}" \;
find $TO_BACKUP_SAFE -mmin +2 -exec rm -rf  "{}" \;


# SAMBA
# https://bayton.org/docs/linux/ubuntu/set-up-samba-ubuntu-12-04/
