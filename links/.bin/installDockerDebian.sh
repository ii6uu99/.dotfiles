#!/bin/bash

sudo apt-get remove docker docker-engine docker.io docker-ce -y --allow-change-held-packages
# Remove obsolete config. Use daemon.json instead
sudo mv /etc/default/docker /etc/default/doc_ker.bak 2> /dev/null

sudo apt-get update

sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common  -y  --allow-change-held-packages

curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce -y
