#!/bin/bash

: ${VERSION:=2.4.11-jdk8-alpine}

VOLUME="/scripts"
DOCKER_IMAGE="groovy:${VERSION}"

volume_option="-v "$(pwd):$VOLUME""
if [[ ! -z "${SHARED_VOLUME}" ]]; then
  volume_option="--volumes-from ${SHARED_VOLUME}"
fi

set -eu

docker run --rm -t $(tty &>/dev/null && echo "-i") \
           ${volume_option} \
           -w $VOLUME \
           $DOCKER_IMAGE "$@"
