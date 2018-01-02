https://github.com/Leafney/alpine-spiderenv-py2


### Alpine-SpiderEnv-Py2

Docker中的环境让蜘蛛得到静态或动态的网页html和解析它。



#### 支持

* requests
* selenium + chrome
* selenium + firefox
* beautifulsoup
* lxml
* Scrapy

#### 不支持

* selenium + phantomjs

#### 环境变量

* `SUPER_ADMIN_NAME` supervisor web 登录用户名 (default `user`)
* `SUPER_ADMIN_PWD` supervisor web 登录密码 (default `123456`)
* `CONFIG_DIR` 用户配置目录名称 (default `config`)

如何使用

从DockerHub获取图像

```
$ docker pull leafney/alpine-spiderenv-py2
```

##建立图像

```
$ docker build -t="leafney/alpine-spiderenv-py2" .
```

#####创建一个默认容器

```
$ docker run --name spiderenv -d -p 9001:9001 -p 61208:61208 leafney/alpine-spiderenv-py2
```
然后http://localhost:9001用默认的用户名user和密码打开浏览器的网址为主管网页，用url浏览网页123456打开http://localhost:61208。
#####创建一个容器来运行你的蜘蛛程序

第一

创建容器与主机目录/home/tiger/spiderfile（可以由您自己设置）挂载到容器的默认目录/app。

这里改变主管网页的用户登录密码tiger。
```
$ docker run --name spiderenv -v /home/tiger/spiderfile:/app -d -p 9001:9001 -p 61208:61208 -e SUPER_ADMIN_PWD=tiger leafney/alpine-spiderenv-py2
```
第二

获取/appgit库示例程序中的文件夹下的三个目录复制到/home/tiger/spiderfile目录：

```
spiderfile/
-- config
    -- hello.conf
-- logs
-- spider
    -- hello
        -- hello.py
```

config此目录用于存储由管理员调用搜寻器程序的配置文件。默认扩展名为*.conf，目录文件夹名称可以由环境变量自定义CONFIG_DIR，但是应该一致
logs用于存放爬虫程序的目录是由监督者日志文件生成的，可以config在相应的配置文件目录中指定爬行类
spider 此目录用于存储搜寻器程序和相关文件
***
在该spider目录中，有一个默认hello.py示例爬网程序。

目录hello.conf下的配置文件config：

```
;
;hello spider program
;

[program:spider_hello]   		            ; program name
command=python hello.py     				; the program (relative uses PATH, can take args)
directory=/app/spider/hello 	            ; directory to cwd to before exec (def no cwd)
user=root   								; setuid to this UNIX account to run the program
autostart=true                           	; start at supervisord start (default: true)
autorestart=true                         	; whether/when to restart (default: unexpected.May be one of false, unexpected, or true)
startsecs=10  								; number of secs prog must stay running (def. 1)
startretries=3                              ; max # of serial start failures (default 3)
stdout_logfile=/app/logs/hello_out.log       ; stdout log path, NONE for none; default AUTO
stderr_logfile=/app/logs/hello_err.log       ; stderr log path, NONE for none; default AUTO
```

The directory path of the configuration file in `*.conf` is the absolute path set for the program directory `/app` in the container. It is recommended to use an absolute path such as `directory=/app/spider/hello`. You can also use relative paths such as `directory=spider/hello`.

In addition, in order to prevent the problem caused by the permission denied of the program executing, the default implementation of the user is set to `root`.

***

配置文件in的目录路径*.conf是/app容器中程序目录的绝对路径。建议使用绝对路径如directory=/app/spider/hello。你也可以使用相对路径如directory=spider/hello。

另外，为了防止由于程序执行被拒绝而导致的问题，用户的默认实现被设置为root。

第三

将配置文件和爬虫添加到相应目录后，重启容器，通过web界面查看爬虫运行情况。

```
$ docker restart spiderenv
```

***

#### Installation Library

* python 2.7.x
* sqlite3
* requests
* selenium + firefox + chrome
* beautifulsoup4
* xmltodict
* lxml
* Scrapy
* apscheduler
* supervisor
* glances
