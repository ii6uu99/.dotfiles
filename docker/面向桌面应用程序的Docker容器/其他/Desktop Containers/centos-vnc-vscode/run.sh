#!/bin/bash

# ENV CONF_API_PORT=4444
# ENV CONF_TRADING_MODE=paper
# ENV CONF_IB_USER=greg2017
# ENV CONF_IB_PASS=alglab111
# ENV CONF_IB_READ_ONLY=no

docker rm -f vscode

docker run -id  -e CONF_VNC_PASS=changeme \
                -e CONF_VNC_PORT=5901 \
                -e CONF_TIMEZONE=America/Chicago \
                -p 5901:5901 \
                -v /home/matthewbrandondavis83/docker-centos-desktop-visualstudiocode/src/home:/home \
                --name vscode \
                 appsoa/docker-centos-desktop-visualstudiocode:latest
