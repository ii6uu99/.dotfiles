#!/bin/bash
docker run -d \
    -p 9001:9001 -p 9002:9002 \
    --name hybris-server \
    -v /Users/benwilcock/src/tmp/hybris:/home/hybris \
    sanwar/hybris-5-7:latest