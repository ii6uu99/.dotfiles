#!/bin/bash
#
# Dockerized Notebook + SciPy Stack
#
# Docker container for the SciPy stack and configured IPython notebook server.
#
# https://github.com/ipython/docker-notebook/tree/master/scipyserver


docker stop ipython-scipyserver
docker rm ipython-scipyserver

docker pull ipython/scipyserver
docker run \
  --volume=/Users/patrick/ipython-notebooks:/notebooks \
  --env="PASSWORD=notebooks" \
  --publish=443:8888 \
  --detach=true \
  --name=ipython-scipyserver \
  ipython/scipyserver

open https://dockerhost/
