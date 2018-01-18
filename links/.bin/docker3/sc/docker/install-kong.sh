#!/bin/bash

docker run -d --name my-cassandra -p 9042:9042 mashape/cassandra
docker run -d --name my-kong -p 8000:8000 -p 8001:8001 --link my-cassandra:cassandra mashape/kong

#docker run -d --name my-kong -v $HOME/src/bw-github/docker-scripts/kong/:/etc/kong/ -p 8000:8000 -p 8001:8001 mashape/kong
