#!/bin/bash
#
# Google cAdvisor
#
# Provides container users an understanding of the resource usage and
# performance characteristics of their running containers.
#
# https://github.com/google/cadvisor


docker stop cadvisor
docker rm cadvisor

docker pull google/cadvisor
docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor
