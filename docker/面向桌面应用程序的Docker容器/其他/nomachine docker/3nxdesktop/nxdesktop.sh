#!/bin/bash
mkdir -p /home/$USER/data
docker run --rm -p 4001:4000 -p 4002:22 \
        -v /home/$USER/data:/home/nomachine/data \
        -v /etc/localtime:/etc/localtime:ro \
        atomney/nxdesktop
