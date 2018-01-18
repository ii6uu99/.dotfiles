#!/bin/bash
docker run -it --rm \
    -e "HOME" \
    -e "USER" \
    -e "UID=$(id -u)" \
    -e "GID=$(id -g)" \
    -v /home/$USER:/home/$USER \
    -v /etc/machine-id:/etc-machine-id:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v $PWD:$PWD \
    -w $PWD \
    --net="host" \
tsari/build-server php "$@"