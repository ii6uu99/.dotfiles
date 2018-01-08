https://github.com/paimpozhil/docker-volume-backup.git

泊坞窗卷备份
注意：最近版本的码头工人，有卷插件和更好的支持，所以你应该使用它，这个项目是有用的时，卷没有这样的功能。

一个用于备份/恢复搬运工数据容器/卷的蟒蛇脚本。

这个脚本特别适用于只有容量的容器，尽管它应该适用于任何有容量的容器。

####需要Python && Docker-py python包。

apt-get install python-pip 
pip install docker-py
##如何使用

python backup.py backup [yourcontainername]
将输出一个焦油文件，其中包含可以移动的容器的名称

python backup.py restore [yourcontainername] [destinationname]
将把焦油备份恢复为新的数据容器

python backup.py help me  
会输出帮助信息。目前确实不是很有帮助

用法示例：
开始你的码头容器有卷..注意我使用我的通用paimpozhil /数据容器，我用我的WhatPanel这是我自己的cPanel更换。

更多信息在这里：https：//github.com/paimpozhil/WhatPanel

root@dockerhost# docker run -td --name mydata  paimpozhil/data
eba7a4aef3e3007d41b81a45e914196c3a74d0e69adaa4f781c2decb83730619

## data container created

root@dockerhost# docker ps
CONTAINER ID        IMAGE                    COMMAND             CREATED              STATUS              PORTS               NAMES
eba7a4aef3e3        paimpozhil/data:latest   /bin/sh             About a minute ago   Up About a minute                       mydata

## Now you see it created now use the volumes in your any other containers

root@dockerhost# docker run -ti --volumes-from mydata ubuntu /bin/bash

root@c2b83b3971c3:/# ls
backup  bin  boot  data  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@c2b83b3971c3:/# cd /data

## create a BIG 100M file
root@c2b83b3971c3:/data# dd if=/dev/urandom of=bigfile bs=1024 count=102400

## exit and try to run another container to ensure the data is there .

root@a09fe3caf955:/data# ls -alth bigfile
-rw-r--r-- 1 root root 100M Jun 19 22:00 bigfile

### exit now and back to the host

root@dockerhost# python backup.py backup mydata

##creates mydata.tar -rw-r--r-- 1 root root 101M Jun 19 22:03 mydata.tar

### now copy it around to any host or just restore here in any other name.

root@dockerhost# python backup.py restore mydata myotherdata
Restoring
/backup /var/lib/docker/vfs/dir/de537270e1d2365f6c3d32116549e54ef480a32e96b4caf51964a949ec875201
/var/lib/mysql /var/lib/docker/vfs/dir/56a88d289ddb8d641fea0c16e972f507c70e34dc81c1460499634e4c900c94ca
/data /var/lib/docker/vfs/dir/5bc67e4aaab669719b7cc24ab709a417a549e03d4eb550108355323895723740
/var/www /var/lib/docker/vfs/dir/de95abd703a13365c5cffecbc05eff533b3ced2fb3fc79f3fdd99e13cc1d299b
docker run --rm -ti --volumes-from e0ff233216f35cc151c081a55fa8943fabfbf86bed0234c801f44a7ecbbdfbd2 -v $(pwd):/backup2  ubuntu tar xvf /backup2/mydata.tar
metadata
backup/
var/lib/mysql/
data/
data/bigfile
var/www/

### now check if you have the correct data

root@dockerhost# docker run -ti --volumes-from myotherdata ubuntu /bin/bash
root@ac5671887ea0:/# cd /data
root@ac5671887ea0:/data# ls
bigfile

## make some changes to the new copy

root@ac5671887ea0:/data# touch this is my other data
root@ac5671887ea0:/data# ls
bigfile  data  is  my  other  this
root@ac5671887ea0:/data#

## Ensure your actual data is intact  :p 

root@dockerhost# docker run -ti --volumes-from mydata ubuntu /bin/bash
root@3acae1260562:/# ls
backup  bin  boot  data  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@3acae1260562:/# cd /data
root@3acae1260562:/data# ls
bigfile
root@3acae1260562:/data#

作为容器运行
首先，你需要建立它：

docker build --rm --no-cache -t docker-volume-backup .
完成后，可以使用以下方法备份：

docker run -t -i --rm \
  -v /var/lib/docker/vfs:/var/lib/docker/vfs \
  -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/backup docker-volume-backup \
  backup <container>
.tar备份将存储在/ backup中，您可以将其绑定到您的docker主机上的任何目录（上面的/ tmp不是一个好主意;））

 docker run -t -i --rm \
  -v /var/lib/docker/vfs:/var/lib/docker/vfs \
  -v /var/run/docker.sock:/var/run/docker.sock \
  restore <backupedcontainer> <newcontainer> <tar storage absolute path on host>
的.tar备份将在“主机上的焦油存储绝对路径”中获取...

信用和参考：
http://docs.docker.com/userguide/dockervolumes/#creating-and-mounting-a-data-volume-container

需要支持？
