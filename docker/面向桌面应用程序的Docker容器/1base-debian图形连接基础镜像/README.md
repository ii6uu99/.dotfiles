https://github.com/DesktopContainers/base-debian

# Debian VNC/Websockify/SSH Desktopcontainers Base Image

构建debian stretch，
可以用VNC, websockify and ssh Server.链接

这是为各种桌面应用程序构建的基础映像。

这些应用程序将以VNC，Websockify VNC，Web（noVNC），SSH或主机X11的形式提供。你可以通过环境变量来改变行为。所以用户可以决定他如何使用应用程序。

Base image: _/debian:stretch_
因为我想要一个几乎任何地方运行的基本系统。

# Environment variables and defaults

- __DISABLE\_SSHD__
    - 设置为任何值，例如true以禁用SSHD - >端口22
   命令连接：ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -X root@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' containername) [...]_
- __DISABLE\_VNC__
    - 将其设置为任意值，例如true以禁用VNC服务器 - >端口5901
- __DISABLE\_WEBSOCKIFY__
   将其设置为任意值，例如true以禁用Websockify服务器 - >端口http 80或https 443
   只需打开浏览器并连接到容器
- __ENABLE\_SUDO__
    - 其将设置为启用，以允许用户使用sudo的
      默认：未设置

- __VNC\_SCREEN\_RESOLUTION__
  如果你想要一个特定的默认值（如在运行时也可以改变），请将其设置为“1280×1024”
默认：未设置
可能的值：
        - 640x480
        - 800x600
        - 1024x768
        - 1280x1024
        - 1280x720
        - 1280x800
        - 1280x960
        - 1360x768
        - 1400x1050
        - 1600x1200
        - 1680x1050
        - 1900x1200
        - 1920x1080
        - 1920x1200

## Websockify SSL

要使用自定义SSL证书，只需将它们添加为文件：

/配置/
SSL-cert.crt
SSL-cert.key
如果您没有提供任何证书，则将在容器启动时创建一个自签名的证书。

## 代理环境变量和默认值

HTTP_PROXY
将其设置为像“ http：// yourproxyaddress：proxyport ” 这样的值来启用代理变量HTTP_PROXY和http_proxy
HTTPS_PROXY
将其设置为像“ http：// yourproxyaddress：proxyport ” 这样的值来启用代理变量HTTPS_PROXY和https_proxy
FTP_PROXY
将其设置为像“ http：// yourproxyaddress：proxyport ” 这样的值来启用代理变量FTP_PROXY和ftp_proxy
NO_PROXY
将其设置为像“ http：// yourproxyaddress：proxyport ” 这样的值来启用代理变量NO_PROXY和no_proxy
APT_PROXY
将其设置为像“ http：// yourproxyaddress：proxyport ” 这样的值，以便在apt配置中启用代理


# 用法
使用以下命令运行容器：

    docker run -d --name debian-base-system -p 5901:5901 -p 80:80 -p 443:443 desktopcontainers/base-debian

连接到容器。在VNC连接字符串中输入：

"localhost:1"
