#!/bin/bash
# File: linux_install_script.sh
# Author: Tim Siwula <tcsiwula@usfca.edu>
# Date: Wed Jul 6th 2016
# This is a script that will install the latest versions of golang, mysql, nginx and docker across multiple linux distributions.
# Run/Complie: bash linux_install_script.sh

# 1 get system type and assign to varibale
system_name=$(cat /etc/*-release)
osx=$(uname -a)

if [[ $system_name == *"Ubuntu"* ]]; then
    distro_name="ubuntu"
elif [[ $system_name == *"Debian"* ]]; then
    distro_name="debian"
elif [[ $system_name == *"SUSE"* ]]; then
    distro_name="suse"
elif [[ $system_name == *"Red"* ]]; then
    distro_name="redhat"
elif [[ $system_name == *"Fedora"* ]]; then
    distro_name="fedora"
elif [[ $system_name == *"Cent"* ]]; then
    distro_name="cent"
elif [[ $osx == *"Darwin"* ]]; then
    distro_name="darwin"
else
    echo "No system_name identified to target an installation."
fi
echo $distro_name

# 2 install software with systems package managers
if [[ $distro_name == "debian" || $distro_name == "ubuntu" ]]; then
    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get install golang
    sudo apt-get install mysql-server mysql-client
    sudo apt-get install nginx
    sudo apt-get install docker.io
elif [[ $system_name == "redhat" || $distro_name == "fedora" || $distro_name == "centos" ]]; then
    sudo yum update
    sudo yum install golang
    sudo yum install mysql-server
    sudo yum install nginx
    sudo yum install docker
elif [[ $distro_name == "suse" ]]; then
    sudo zypper install golang
    sudo zypper install mysql
    sudo zypper install nginx
    sudo zypper install docker
else
    echo "No system_name identified to install software on."
fi

# 3 verify if software is working
go version
mysql -V
nginx -v
docker version
