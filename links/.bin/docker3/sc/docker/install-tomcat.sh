#!/bin/bash
docker run -it -d --name my-tomcat -v $HOME/src/bw-github/docker-scripts/tomcat/tomcat-users.xml:/usr/local/tomcat/conf/tomcat-users.xml:ro -p 8080:8080 tomcat
