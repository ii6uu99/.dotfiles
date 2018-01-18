#!/bin/bash
# Cleans up any tagless images
# I don't  use the "-a" flag here because it'll pick up untagged images that can't be removed due to dependencies
docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
