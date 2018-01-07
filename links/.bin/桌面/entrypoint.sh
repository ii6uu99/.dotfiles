#!/bin/bash
# general good practice (stop on error, missing variables):
set -eu

# Creating user: $USER ($UID:$GID)
homeCommand="--create-home"
if [ -d "/home/$USER" ]; then
    homeCommand="-d /home/$USER"
fi
groupadd --system --gid=$GID $USER && useradd --system --gid=$GID --uid=$UID $USER && \

exec sudo -u $USER "$@"