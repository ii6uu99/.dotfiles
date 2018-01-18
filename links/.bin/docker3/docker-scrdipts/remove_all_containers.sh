#!/bin/bash
#Removes ALL containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
