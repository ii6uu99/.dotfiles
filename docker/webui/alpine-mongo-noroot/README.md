

https://github.com/mvertes/docker-alpine-mongo

搬运工高山，蒙戈



这个存储库包含 基于Alpine边缘图像的用于MongoDB 3.4容器的Dockerfile 。

为什么？官方的mongo镜像大小：360 MB，高山语言：106 MB

安装

作为先决条件，您需要安装Docker。

要从公共码头中心下载此图像：

$ docker pull mvertes/alpine-mongo
从dockerfile重新构建这个镜像：

$ docker build -t mvertes/alpine-mongo .
用法

运行mongod：

$ docker run -d --name mongo -p 27017:27017 mvertes/alpine-mongo
您还可以使用volume -v选项指定存储数据的数据库存储库：

$ docker run -d --name mongo -p 27017:27017 \
  -v /somewhere/onmyhost/mydatabase:/data/db \
  mvertes/alpine-mongo
运行一个shell会话：

$ docker exec -ti mongo sh
要使用mongo shell客户端：

$ docker exec -ti mongo mongo
mongo shell客户端也可以运行自己的容器：

$ docker run -ti --rm --name mongoshell monogo host:port/db
限制

在MacOSX上，由于virtualbox（默认docker-machine驱动程序）不支持fsync（）的限制，不支持位于virtualbox共享文件夹中的卷。
