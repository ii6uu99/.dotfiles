#!/usr/bin/env bash

# Docker标签升级

set -o errexit
set -o pipefail
set -o nounset

error() {
  >&2 echo "$1"
}

usage() {
  error "USAGE: $0 image tag"
}

main() {
  echo "# START UPGRADE DOCKER TAGS"
  docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
  filesearch
}

filesearch() {
  for i in `seq ${#DOCKER_TAG} -1 1`; do
    TAGS_FILE=v${DOCKER_TAG:0:$i}

    if [ -e "${TAGS_FILE}" ]; then
      upgrade "$TAGS_FILE"
      exit 0
    fi
  done

  error "Could not found a tag file in '$PWD'"
  exit 1
}

upgrade() {
  TAGS_FILE=$1
  echo -n "# USING ${TAGS_FILE} FILE FOR TAGING: "
  echo $(cat ${TAGS_FILE})

  while read p; do
    docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:$p
    docker push ${DOCKER_IMAGE}:$p
  done <${TAGS_FILE}

  echo "# FINISH UPGRADE DOCKER TAGS"
}


DOCKER_IMAGE="${1:-}"
DOCKER_TAG="${2:-}"

if [ -z "${DOCKER_IMAGE}" ] || [ -z "${DOCKER_TAG}" ]; then
  usage
else
  main
fi
