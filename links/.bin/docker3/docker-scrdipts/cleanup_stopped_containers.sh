#!/bin/bash
# Removes all stopped containers
docker rm $(docker ps -a -q)
