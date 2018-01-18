#!/bin/bash

echo "Delete dangling=true volumes:"
docker volume ls --filter dangling=true

read -p "Are you sure? (y/Y)" -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

docker volume rm $(docker volume ls -q --filter dangling=true)
