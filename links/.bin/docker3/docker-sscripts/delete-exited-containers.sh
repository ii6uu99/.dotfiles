#!/bin/bash

echo "Delete status=exited containers:"
docker ps -a -f status=exited

read -p "Are you sure? (y/Y)" -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

docker rm -v $(docker ps -a -q -f status=exited)
