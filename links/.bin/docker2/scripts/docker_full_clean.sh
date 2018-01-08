#!/bin/bash
# Delete all containers
./docker_clean.sh
# Delete all images
docker rmi $(docker images -q)
