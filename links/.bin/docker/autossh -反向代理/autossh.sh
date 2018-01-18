#!/bin/sh

if [[ -z ${AUTOSSH_KEY_FILE} ]]
    then
        echo "No ssh key provided!"
        exit
fi

autossh -M 0 -4 -N \
        -o "ServerAliveInterval 60" \
        -o "ServerAliveCountMax 3" \
        -o BatchMode=yes \
        -o StrictHostKeyChecking=no \
        ${AUTOSSH_USER}@twill-dcos-mgmt.westeurope.cloudapp.azure.com \
        -p ${AUTOSSH_PORT} -i ${AUTOSSH_KEY_FILE}