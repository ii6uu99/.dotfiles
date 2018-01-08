#!/bin/bash

SCRIPT="$(basename "$0")"

if [[ "$#" -eq 1 ]] && [[ "$1" == "--help" || "$1" == "-h" || "$1" == "help" ]]; then
    echo "Usage: ${SCRIPT} [<working dir>]";
    echo -e "\tunless otherwise specified, current working dir will be used by default"
    exit 0;

fi

if [ "$#" -lt 1 ]; then
    NOTEBOOK_LOCAL_DIR=`pwd`
else
    if [ -d "$1" ];
    then
        NOTEBOOK_LOCAL_DIR=$1
    else
        NOTEBOOK_LOCAL_DIR=`pwd`
    fi
fi

docker run -i -t \
       -p 8888:8888 \
       -v $NOTEBOOK_LOCAL_DIR:/opt/notebooks \
       --rm \
       my/anaconda-python2 \
       /bin/bash -c \
       "useradd dev --create-home \
       && su - dev -c \"/opt/conda/bin/jupyter notebook \
       --notebook-dir=/opt/notebooks \
       --ip='*' \
       --port=8888 \
       --no-browser\""
