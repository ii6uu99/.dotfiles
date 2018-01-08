#!/usr/bin

# Commmands pretty much copied and pasted from
# https://docs.docker.com/engine/installation/linux/debian/

sudo apt-get purge lxc-docker*
sudo apt-get purge docker.io*
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates -y
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo sh -c "echo 'deb https://apt.dockerproject.org/repo debian-jessie main' > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-cache policy docker-engine
sudo apt-get update
sudo apt-get install docker-engine -y
sudo service docker start
sudo docker run hello-world



