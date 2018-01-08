#!/bin/sh

sudo apt-get purge -y maven
sudo wget -P ~/Downloads/ http://mirrors.sonic.net/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
sudo tar -zxf ~/Downloads/apache-maven-3.3.3-bin.tar.gz -C /usr/local/
sudo ln -s /usr/local/apache-maven-3.3.3/bin/mvn /usr/bin/mvn
echo "Maven is on version `mvn -v`"
