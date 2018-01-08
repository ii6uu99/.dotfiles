for image in $(docker ps -a | awk '{print $2}' | tail -n +2);
do 
	docker pull $image;
done
