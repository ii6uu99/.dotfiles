#!/bin/sh

DOCKER_IMAGE=mustardgrain/kafka:latest
docker_args="--interactive --rm"

if [ -t 0 ] ; then
  docker_args="${docker_args} --tty"
fi

docker run $docker_args $DOCKER_IMAGE ./bin/kafka-console-producer.sh $@
