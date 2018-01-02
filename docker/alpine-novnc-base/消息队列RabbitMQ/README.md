### alpine-rabbitmq-standalone

Small RabbitMQ image of standalone.

***

从DockerHub获取图像

```
$ docker pull leafney/alpine-rabbitmq-standalone
```

创建一个默认的rabbitmq容器

```
$ docker run --name rmq -d -p 5672:5672 -p 15672:15672 leafney/alpine-rabbitmq-standalone
```

与浏览器http://localhost:15672默认user和123456。



***

自定义容器

自己设置登录用户和密码，并从容器中挂载rabbitmq日志和数据。
```
$ docker run --name rmq -d -p 5672:5672 -p 15672:15672 -v /home/tiger/rmqfiles:/rabbitmq/var -e RMQ_USER=tom -e RMQ_PWD=123123 leafney/alpine-rabbitmq-standalone
```
