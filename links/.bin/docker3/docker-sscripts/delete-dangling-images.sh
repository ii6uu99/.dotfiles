#!/bin/bash

echo "Delete dangling=true images:"
docker images -f "dangling=true"

read -p "Are you sure? (y/Y)" -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

docker rmi $(docker images -f "dangling=true" -q)
