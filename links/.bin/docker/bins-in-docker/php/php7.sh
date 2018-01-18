#!/bin/bash

set -e

IMAGE="php:7.0-cli"


# Setup volume mounts
if [ "$(pwd)" != '/' ]; then
    VOLUMES="-v $(pwd):$(pwd)"
else
    echo "don't use root (/) dir for executing this"
    exit 1
fi

# Only allocate tty if we detect one
if [ -t 1 ]; then
    RUN_OPTIONS="-t"
fi
if [ -t 0 ]; then
    RUN_OPTIONS="$RUN_OPTIONS -i"
fi

exec docker run --user=$UID --rm $RUN_OPTIONS $VOLUMES -w "$(pwd)" $IMAGE php "$@"