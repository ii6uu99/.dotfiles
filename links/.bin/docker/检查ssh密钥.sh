#!/usr/bin/env bash

#检查docker安装
DOCKER=$(which docker)
if [ -z "$DOCKER" ]
then
	echo "Docker not found... Please install Docker before running BinaryJail."
	exit

	echo "Docker not found... Press Enter to install (requires admin privileges), ctrl-c to quit:"
	read line
	sudo apt-get update && sudo apt-get install -y curl
	curl -sSL https://get.docker.com/ubuntu/ | sudo sh
	sudo chmod a+rw /var/run/docker.sock
else
	echo "Found docker at $DOCKER..."
fi

#检查Node.js安装
NODE=$(which node)
if [ -z "$NODE" ]
then
	echo "Node.js (specifically, the binary named node) not found... Please install Node.js before running BinaryJail."
	exit

	echo "Node.js not found... Press Enter to install (requires admin privileges), ctrl-c to quit:"
	read line
	sudo apt-get update && sudo apt-get install -y nodejs
	sudo ln -s /usr/bin/nodejs /usr/local/bin/node
else
	echo "Found node.js at $NODE..."
fi

#检查ssh密钥
SSH_KEY=$HOME/.ssh/dockerbox
if [ -f $SSH_KEY ] && [ "`ssh-keygen -l -f $SSH_KEY | grep \"^[0-9]\+\"`" ]
then
	echo "Dockerbox keypair found at $SSH_KEY..."
else 
	echo "Dockerbox keypair not found at $SSH_KEY. Creating..."
	ssh-keygen -t rsa -f $SSH_KEY -P ""
	echo "Created..."
fi
cp $SSH_KEY.pub .

#建立容器
docker build --rm=true -t dockerbox/base .
echo "Installed BinaryJail! Please re-run your command."
