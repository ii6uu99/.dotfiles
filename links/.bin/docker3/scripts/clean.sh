#!/bin/bash
#清理所有容器
docker ps -aq | xargs docker stop
docker ps -aq --no-trunc | xargs docker rm
