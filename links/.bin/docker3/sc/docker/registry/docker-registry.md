# Creating a Local Docker Image Registry

Taken from here: https://docs.docker.com/registry/deploying/

Start your registry:

````bash
docker run -d -p 5000:5000 --restart=always --name registry registry:2
````

Get any image from the hub and tag it to point to your registry:

````bash
docker pull ubuntu && docker tag ubuntu localhost:5000/ubuntu
````

Now push the image to your registry

````bash
docker push localhost:5000/ubuntu
````

To pull it back from your registry:

````bash
docker pull localhost:5000/ubuntu
````

To stop your registry, you would:

````bash
docker stop registry && docker rm -v registry
````
