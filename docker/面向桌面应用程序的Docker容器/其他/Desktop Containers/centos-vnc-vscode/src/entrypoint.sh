#!/bin/bash

DIR=entrypoint.d/*

if [[ $DIR ]]; then

    for i in $DIR; do

        echo "[entrypoint.d] Running $i"

        $i

    done

fi

exec "$@"