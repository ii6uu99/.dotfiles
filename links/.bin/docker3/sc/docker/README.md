# docker-scripts

## List running containers...
```
docker ps
```

## List stopped containers...
```
docker ps -f "status=exited"
```

## To remove a container...
```
docker rm <container-name>
```

## List images...
```
docker images
```

## To remove an image...
```
docker rmi <image-name>
```

# Registry...

Start your registry:
````
docker run -d -p 5000:5000 --restart=always --name registry registry:2
````
You can now use it with docker.

Get any image from the hub and tag it to point to your registry:
````
docker pull ubuntu && docker tag ubuntu localhost:5000/ubuntu
````
… then push it to your registry:
````
docker push localhost:5000/ubuntu
````
… then pull it back from your registry:
````
docker pull localhost:5000/ubuntu
````
To stop your registry, you would:
````
docker stop registry && docker rm -v registry
````




