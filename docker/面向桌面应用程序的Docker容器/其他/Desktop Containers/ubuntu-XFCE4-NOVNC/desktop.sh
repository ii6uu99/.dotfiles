#!/bin/bash

########## VARIABLES
# HERE
HERE=`pwd`

# CONTAINER NAMES
D1NAME=d1

# PORTS
D1PORT=8079:6080
D1SSH=172.17.0.1:8080:22
D1WEB=8081:8081
D1SOUND=8082:8082

# VNC PASSWORD
VNCPASS=YOURPASS

# MEMORY FOR EACH DESKTOP
MEMORY=128m

# IMAGE NAME
IMAGENAME=atomney/dockerdesktopnovnc

# CREATE DATA DIRECTORY
mkdir -p $HERE/data

# START THE CONTAINER WITH CERT
if [ "$1" = "--start" ]; then

 docker run --rm -v /etc/localtime:/etc/localtime:ro -p $D1PORT \
        -v $HERE/startup.sh:/startup.sh \
        -p $D1SSH -p $D1WEB -p $D1SOUND \
        -v /dev/shm:/dev/shm \
        --device /dev/snd \
        --device /dev/dri \
        --group-add audio \
        --cap-add=NET_ADMIN \
        -v $HERE/self.pem:/root/noVNC/self.pem \
        -v $HERE/data:/home/tux/data \
        -e VNCPASS=$VNCPASS --name $D1NAME -h $D1NAME -m $MEMORY $IMAGENAME &
fi

# START THE CONTAINER NO CERT
if [ "$1" = "--startnossl" ]; then

 docker run --rm -v /etc/localtime:/etc/localtime:ro -p $D1PORT \
        -p $D1SSH -p $D1WEB -p $D1SOUND \
        -v /dev/shm:/dev/shm \
        --device /dev/snd \
        --device /dev/dri \
        --group-add audio \
        --cap-add=NET_ADMIN \
        -v $HERE/data:/home/tux/data \
        -e VNCPASS=$VNCPASS --name $D1NAME -h $D1NAME -m $MEMORY $IMAGENAME &

fi

# STOP AND REMOVE THE CONTAINER
if [ "$1" = "--remove" ]; then

        docker stop $D1NAME
        docker rm $D1NAME
fi

# RESTART THE CONTAINER
if [ "$1" = "--restart" ]; then

        bash $0 --remove &&
        sleep 2
        bash $0 --start
fi

# PULL THE NEWEST CONTAINER IMAGE
if [ "$1" = "--update" ]; then

        docker pull $IMAGENAME
        bash $0 --remove
        bash $0 --start
fi

# GENERATE SELF SIGNED CERT
if [ "$1" = "--cert" ]; then

        openssl req -new -x509 -days 365 -nodes -out self.pem -keyout self.pem
fi
