#!/bin/bash
docker run -d --name my-jenkins --link my-mongo --link my-rabbit -v /var/jenkins_home -p 8088:8080 -p 50000:50000 jenkins
