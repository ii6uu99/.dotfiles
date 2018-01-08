#!/bin/bash
# Cleans the docker daemon of all images that are not connected to any tagged image
#清除未连接到任何标记映像的所有映像的docker守护进程
docker images -aqf dangling=true | xargs docker rmi
