https://github.com/DesktopContainers/icaclient.git


# Citrix ICA-Client
Citrix ICA客户端插件与Mozilla Firefox捆绑在一起

思杰icaclient是一个非常糟糕的设计一个可怕的实施远程桌面连接工具。它是一个32位的火狐插件，即使在64位的的Linux的系统上也是如此，所以它会破坏你的操作系统，或者至少是你的火狐的安装。即使这样，它需要修复，大部分时间，这是行不通的。不过我必须在工作中使用它。所以我想在一个定义良好的环境中运行它：封装在泊坞窗容器中。

它基于DesktopContainers / base-debian

ICA-客户端许可证
将CITRIX RECEIVER LICENSE AGREEMENT存储在文件中LICENSE。LICENSE如果您使用这个码头集装箱，您必须接受。

您也可以从以下网址下载客户端：

https://www.citrix.com/downloads/citrix-receiver/linux/receiver-for-linux-latest.html

环境变量和默认值
的的的web_url
指定浏览器默认指向的URL，例如思杰登录入口网址
用法：运行客户端
简单的SSH X11转发
由于它是一个X11 GUI软件，用法分两步：

运行后台容器作为服务器或启动现有的一个。


```
docker start icaclient || 

docker run -d --name icaclient \
-e 'WEB_URL=https://github.com' desktopcontainers/icaclient
```

  2. 使用ssh -X（尽可能多的次数）连接到服务器。 用ssh自动登录打开一个窗口显示火狐

```
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
-X app@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' icaclient)
```

  3. 浏览您的ICA服务，启动客户端并享受。
你可以配置的火狐和设置书签。只要你不删除容器，你重复使用相同的容器，所有的更改仍然存在。您也可以标记和推送您的配置到注册表进行备份（应为您自己的私人注册表为您的隐私）。
