Docker + Alpine-3.4 + Mysql/MariaDB-10.1.18

#### 参数

* `MYSQL_ROOT_PWD` :mysql默认root密码
* `MYSQL_USER`     : new User
* `MYSQL_USER_PWD` : new User Password
* `MYSQL_USER_DB`  : 新用户的新数据库

#### build image

```
$ docker build -t="leafney/docker-alpine-mysql" .
```

#### 运行一个默认的contaier

```
$ docker run --name mysql -v /mysql/data/:/var/lib/mysql -d -p 3306:3306 leafney/docker-alpine-mysql
```

#### 用新的用户名和密码运行一个容器

```
$ docker run --name mysql -v /mysql/data/:/var/lib/mysql -d -p 3306:3306 -e MYSQL_ROOT_PWD=123 -e MYSQL_USER=dev -e MYSQL_USER_PWD=dev leafney/docker-alpine-mysql
```

#### 运行新的用户和密码的数据库容器

```
$ docker run --name mysql -v /mysql/data/:/var/lib/mysql -d -p 3306:3306 -e MYSQL_ROOT_PWD=123 -e MYSQL_USER=dev -e MYSQL_USER_PWD=dev -e MYSQL_USER_DB=userdb leafney/docker-alpine-mysql
```
