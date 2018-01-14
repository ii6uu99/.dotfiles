#!/bin/bash

sudo apt-get -y update && sudo apt-get -y upgrade

sudo apt-get install -y --no-install-recommends \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common \
     python-software-properties


curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -

sudo add-apt-repository \
            "deb https://apt.dockerproject.org/repo/ \
       debian-$(lsb_release -cs) \
       main"

sudo apt-get update

#安装制定版本，避免dpkg错误
#查找制定版本  apt-cache madison docker-engine
#http://www.linuxidc.com/Linux/2017-01/139985.htm
sudo apt-get -y install dock-engine=1.6.0-0~jessie

sudo systemctl enable docker
