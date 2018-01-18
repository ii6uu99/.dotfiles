#!/usr/bin

# update
sudo apt-get update

# install
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

# add GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# verify
sudo apt-key fingerprint 0EBFCD88

# set up repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# update
sudo apt-get update

# install
sudo apt-get install docker-ce

# verify
sudo docker run hello-world

echo "Run commands with sudo."
