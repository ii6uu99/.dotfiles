#!/bin/bash
#Removes ALL images
#NOTE: remove all containers first before running this!
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -a -q)
