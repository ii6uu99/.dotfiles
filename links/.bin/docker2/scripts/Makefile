instances=`docker ps -aq`
images=`docker images -q`


test:
	./autoconf.sh
stop:
	./docker_clean.sh
clean: stop
	docker rmi $(images)
