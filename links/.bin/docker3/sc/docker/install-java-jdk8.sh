#!/bin/bash
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default
echo "JAVA_HOME `$JAVA_HOME`"
echo "Java is on version `java -version`"

