docker create \
	--name jenkins \
	-v /storage/jenkins:/var/jenkins_home \
	-p 6060:8080 \
	-p 50000:50000 \
	--user 998 \
	jenkins/jenkins:lts

