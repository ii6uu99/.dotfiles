#!/bin/bash
#
# docker-openrefine
#
# A Dockerfile setting up OpenRefine 2.6 with some useful extensions.
#
# https://github.com/SpazioDati/docker-openrefine


docker stop openrefine
docker rm openrefine

docker pull spaziodati/openrefine
docker run \
  --publish=3333:3333 \
  --detach=true \
  --name=openrefine \
  spaziodati/openrefine

open http://dockerhost:3333/
