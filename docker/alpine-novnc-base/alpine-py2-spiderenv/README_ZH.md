### Alpine-SpiderEnv-Py2

Docker下获取并解析静态或动态网页源码的爬虫环境。

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

* `SUPER_ADMIN_NAME` supervisor web页面默认用户名称 (默认 `user`)
* `SUPER_ADMIN_PWD` supervisor web页面默认用户密码 (默认 `123456`)
* `CONFIG_DIR` 用户爬虫配置文件所在目录名称 (默认 `config`)

#### 如何使用

##### 从 DockerHub 获取镜像

```
$ docker pull leafney/alpine-spiderenv-py2
```

##### 构建镜像

```
$ docker build -t="leafney/alpine-spiderenv-py2" .
```

##### 创建一个默认容器

```
$ docker run --name spiderenv -d -p 9001:9001 -p 61208:61208 leafney/alpine-spiderenv-py2
```

然后在浏览器中使用默认账户名称 `user` 和 账户密码 `123456` 打开 `http://localhost:9001` 查看 supervisor 后台进程信息，打开 `http://localhost:61208` 查看 glances 监控信息。

##### 创建容器运行爬虫程序

###### 首先

创建容器将主机目录下的 `/home/tiger/spiderfile` (该主机目录可随意设置) 挂载到容器中的默认目录 `/app` 下。

这里更改了 supervisor web页面的用户登录密码为 `tiger`。

```
$ docker run --name spiderenv -v /home/tiger/spiderfile:/app -d -p 9001:9001 -p 61208:61208 -e SUPER_ADMIN_PWD=tiger leafney/alpine-spiderenv-py2
```

###### 然后

将git库中的示例程序目录 `app` 下的三个文件夹拷贝到 `/home/tiger/spiderfile` 目录下：

```
spiderfile/
-- config
    -- hello.conf
-- logs
-- spider
    -- hello
        -- hello.py
```

* `config` 目录用于存放爬虫程序被supervisor调用的配置文件，默认扩展名为 `*.conf`，该目录名称用户可通过环境变量参数 `CONFIG_DIR` 自定义，但要保持一致
* `logs` 目录用于存放爬虫程序被supervisor调用过程中产生的日志文件，可在 `config` 目录下爬虫程序对应的配置文件中指定
* `spider` 目录用于存放爬虫程序及相关依赖文件

***

在 `spider` 目录下默认有一个 `hello.py` 示例爬虫程序。 

`config`目录下的配置文件 `hello.conf` :

```
;
;hello 爬虫项目
;

[program:spider_hello]   		            ;服务的名称
command=python hello.py     				; supervisor启动命令
directory=/app/spider/hello 	            ; 项目的文件夹路径
user=root   								; 进程执行的用户身份
autostart=true                           	; 是否自动启动
autorestart=true                         	; 是否自动重启
startsecs=10  								; 自动重启间隔
startretries=3                              ; 启动失败重试次数
stdout_logfile=/app/logs/hello_out.log       ; log日志
stderr_logfile=/app/logs/hello_err.log       ; 错误日志
```

`*.conf` 中的配置文件的目录路径都是针对于容器中的程序目录 `/app` 来设置的绝对路径，推荐使用绝对路径如 `directory=/app/spider/hello` 来设置。也可以使用相对路径如 `directory=spider/hello` 。

另外，为防止因权限问题导致爬虫程序执行时出错，默认执行用户设置为 `root` 。

***

###### 最后

将配置文件及爬虫程序添加到相应目录下之后，重启容器，通过web界面查看爬虫运行情况。

```
$ docker restart spiderenv
```

***

#### 安装库

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
