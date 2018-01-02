### Alpine-Mongo

alpine mongo image

#### 拉取镜像

```
$ docker pull leafney/alpine-mongo
```

#### 运行默认容器

```
$ docker run --name mongo -d -p 27017:27017 leafney/alpine-mongo
```

#### 通过自己的配置运行一个容器

```
$ docker run --name mongo --restart=always -d -p 27017:27017 -v /home/tiger/mongo:/data leafney/alpine-mongo
```

获取/datagit的示例库中程序的文件夹数下的三个目录复制到/home/tiger/mongo目录：



```
data
-- config
    -- mongod.conf
-- db
-- logs
```

可以您自定义mongod.conf文件中的设置。

然后，重新启动容器：

```
$ docker restart mongo
```
