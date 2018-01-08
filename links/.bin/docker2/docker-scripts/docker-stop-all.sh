#!/bin/bash
# 停止所有当前正在运行的容器
docker ps -qf status=running | xargs docker stop
