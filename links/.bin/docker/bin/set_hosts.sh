#!/bin/bash

# 变量
declare -a CONTAINERS
HOSTS_FILE=/etc/hosts

## 功能

# 获取容器IP地址
getContainerIP()
{
# $1 - 容器名称
    if [ $1 ]; then
        echo $(docker inspect $1 | grep IPAddress | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | awk '{ print $2 }' | cut -f2 -d\" | head -n1)
#        return 0
    else
	    return 1
    fi
}

# 获取容器名称
getContainerName()
{
# $1 - 容器名称
    if [ $1 ]; then
        echo $(docker inspect $1 | grep Name | grep -E '"/' | awk '{ print $2 }' | cut -f2 -d\" | cut -f2 -d/)
        return 0
    else
        return 1
    fi
}

# ＃检查容器是否在主机上发布
checkIfExistsInHosts()
{
# $1 - Container Name 
    if [[ $(sed -En -e "/\<$1(\s|$)/p" $HOSTS_FILE) ]] && [ $1 ]; then
        return 0
    else
        return 1
    fi
}

# 更新hosts文件中的IP地址
updateIpAddress()
{
# $1 - 容器名称
# $2 - 容器IP地址
    if [ $1 ] && [ $2 ]; then
#$(sed -i -E -e "s/(^ *[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3})(\s*)(\<$1(\s|$))/192.168.200.0\2\3/" $HOSTS_FILE) 
       $(sed -i -E -e "s/(^ *[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3})(\s*)(\<$1(\s|$))/$2\2\3/" $HOSTS_FILE) 
        return 0
    else 
        return 1
    fi
}

addNewHost()
{
# $1 - 容器名称 
# $2 - 容器IP地址
    if [ $1 ] && [ $2 ]; then
        $(echo -e "$2\t$1" >> $HOSTS_FILE)
        return 0
    else 
        return 1
    fi
}

setHost()
{
# 发布或更新容器IP的主要功能
#
# $1 -  容器名称
CONTAINER_NAME=$(getContainerName $1)
CONTAINER_IP=$(getContainerIP $1)

    if [ -z $1 ] ; then
        echo "No containers found!"
        exit 0
    fi

    # 检查它是否已经发布（在/ etc / hosts中）
    if checkIfExistsInHosts $CONTAINER_NAME ; then
        echo "Updating IP: " $CONTAINER_NAME-$CONTAINER_IP
        # 更新IP地址
        updateIpAddress $CONTAINER_NAME $CONTAINER_IP
    else
        echo "Publishing new server: " $CONTAINER_NAME-$CONTAINER_IP
        # 发布容器IP地址
        addNewHost $CONTAINER_NAME $CONTAINER_IP
    fi
}


## 结束函数
echo 
echo '开始过程....'
echo 

# 检查你是否有任何特定的主机
if [ -z $1 ]; then
    # 获取所有容器
    CONTAINERS=$(docker ps -q)

    # 遍历所有容器
    for CONTAINER in $CONTAINERS; do
        setHost $CONTAINER        
    done
else
    setHost $1
fi

exit 0
