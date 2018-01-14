#!/bin/bash -x


##撤回停止的容器

docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm

##如果你不想删除所有的容器，你可以过滤像下面的几天和几周
#docker ps -a | grep Exited | grep "days ago" | awk '{print $1}' | xargs docker rm
#docker ps -a | grep Exited | grep "weeks ago" | awk '{print $1}' | xargs docker rm

##删除悬挂的图像
##有建筑码头图像期间正在创建的图层图像。这是恢复旧的和未使用的图层使用的空间的好方法。

docker rmi $(docker images -f "dangling=true" -q)

##＃删除特定图案的图像例如
##在这里，我正在删除具有SNAPSHOT的图像

docker rmi $(docker images | grep SNAPSHOT | awk '{print $3}')

##删除旧的图像

docker images | grep "weeks ago" | grep -v ubuntu | grep -v alpine | grep -v java | awk '{print $3}' | xargs docker rmi

##＃＃同样你也可以删除几天，几个月的图像。

