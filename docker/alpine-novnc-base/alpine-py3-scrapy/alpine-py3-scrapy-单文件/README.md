# docker-scrapy


https://github.com/ownport/docker-scrapy


Dockerized scrapy based on Alpine Linux




scrapy-latest:
	docker build -t ownport/scrapy:latest .

scrapy-1.4.0:
	docker build -t ownport/scrapy:1.4.0 --build-arg SCRAPY_VERSION='==1.4.0' .



## How to run container

```sh
$ docker run -ti --rm --name scrapy:latest --user $(id -u):$(id -g) -v $(pwd):/data ownport/scrapy:latest /bin/sh
```
