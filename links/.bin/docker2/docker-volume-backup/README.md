https://github.com/kiview/docker-volume-backup

泊坞窗卷备份
便于备份和恢复Docker卷的脚本

用法
./docker_volume_backup.sh {compose_file_path} {project_name} {backup_path} {backup_or_restore} {restore_date}
例子
备用

./docker_volume_backup.sh /home/kiview/Gitlab/docker-compose.yml gitlab $(pwd)/backup backup
恢复

./docker_volume_backup.sh /home/kiview/Gitlab/docker-compose.yml gitlab $(pwd)/backup restore 2016-10-19
Docker容器的使用
建立你的容器后，你可以像这样使用它：

docker run -v "/home/kiview/Gitlab/:/project" \
    -v "$(pwd)/backup:/backup" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker_volume_backup:latest Gitlab /backup backup
注意你不需要提供docker-compose.yml的路径。假定它被挂载在/project/docker-compose.yml下。


# docker-volume-backup
Scripts for easy backup and restore of Docker volumes

## Usage

```
./docker_volume_backup.sh {compose_file_path} {project_name} {backup_path} {backup_or_restore} {restore_date}
```

## Examples

Backup

```
./docker_volume_backup.sh /home/kiview/Gitlab/docker-compose.yml gitlab $(pwd)/backup backup
```

Restore

```
./docker_volume_backup.sh /home/kiview/Gitlab/docker-compose.yml gitlab $(pwd)/backup restore 2016-10-19
```
## Docker Container Usage
After building your container, you can use it like this:
```
docker run -v "/home/kiview/Gitlab/:/project" \
    -v "$(pwd)/backup:/backup" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker_volume_backup:latest Gitlab /backup backup
```
Note you don't need to provide the path to docker-compose.yml. It is assumed to be mounted under /project/docker-compose.yml. 
