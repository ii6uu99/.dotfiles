#!/bin/bash
# 清除所有不在运行的容器的docker守护进程
docker ps -aqf status=exited | xargs docker rm -v
