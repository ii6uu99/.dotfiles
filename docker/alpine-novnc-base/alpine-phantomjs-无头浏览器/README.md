# nodegit-alpine
-------

This image uses the [node:alpine](https://hub.docker.com/_/node/) as a base image and extends it with the [phantom](http://phantomjs.org) package, because download time of the phantom binaries takes really long time.
该图像使用节点：阿尔卑斯山作为基础图像，并用幻影包进行扩展，因为幻影二进制文件的下载时间需要很长时间。
-------

## Build

```bash
git clone git@github.com:Pet3rMatta/phantomjs-alpine.git
cd phantomjs-alpine
docker build --tag phantomjs-alpine .
```

-------

##用法

* `docker pull docker pull pet3rmatta/phantomjs-alpine` - Pull from the repository.
* `FROM phantomjs-alpine` - Simply build your image.




clean:
	docker rmi -f $(docker images -a  | grep "^<none>" | awk '{print $3}')

build:
	docker build -t slavik0/alpine-phantomjs:latest -t slavik0/alpine-phantomjs:${VERSION} .

使用了这个二进制安装包
https://github.com/fgrehm/docker-phantomjs2
