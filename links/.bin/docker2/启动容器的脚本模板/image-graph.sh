#!/bin/bash
#
# image-graph
#
# Generates a nice graph showing the hierarchy of Docker images in your
# local image cache.
#
# https://github.com/CenturyLinkLabs/docker-image-graph


docker stop docker-image-graph
docker rm docker-image-graph

docker pull centurylink/image-graph
docker run \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --env=PORT=3000 \
  --publish=3000:3000 \
  --detach=true \
  --name docker-image-graph \
  centurylink/image-graph
