https://github.com/DesktopContainers/rdesktop-nano.git
没有窗口管理器的rdesktop客户端 - 非常适合终端服务器访问


rdesktop纳米

小型rdesktop码头集装箱与终端服务器完美的使用。

它基于debian：jessie

用法：运行客户端
它使用与底层vnc服务器相同的屏幕分辨率

环境变量和默认值
RDESKTOP_SERVER 将其设置为rdp服务器地址

RDESKTOP_OPTS 默认没有设置使用这个来设置rdesktop的选项。请参阅rdesktop的命令行选项

RDESKTOP_KEEP_ALIVE 设置为任何值，例如true，以便在rdesktop死后重新连接，退出等等。

DISABLE_SSHD 设置为任何值，例如true以禁用SSHD - >端口22

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -X root@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' containername) [...]

DISABLE_VNC

将其设置为任意值，例如true以禁用VNC服务器 - >端口5901

VNC_PASSWORD

默认：debian使用VNC的自定义密码

VNC_SCREEN_RESOLUTION

默认：1280x800

DISABLE_WEBSOCKIFY

将其设置为任意值，例如true以禁用Websockify服务器 - >端口80

Websockify SSL环境变量和默认值
ENABLE_SSL
将其设置为任意值，例如true以启用SSL Websockify服务器
SSL_ONLY
将其设置为任何值，例如true，以仅为Websockify服务器设置SSL
SSL_CERT
默认：/opt/websockify/self.pem包含密钥的证书路径
SSL_SIZE
默认值：4086个密钥
SSL_DAYS
默认：3650 ssl证书生命周期
SSL_SUBJECT
默认：/ C = XX / ST = XXXX / L = XXXX / O = XXXX / CN = localhost ssl cert subject
代理环境变量和默认值
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
用法
使用以下命令运行容器：

docker run -d --name debian-base-system -p 5901:5901 -p 80:80 desktopcontainers/base-debian

连接到容器。在vnc连接字符串中输入：

“IPADDRESS：1”

默认密码是“debian”


简单的SSH X11转发
由于它是一个X11 GUI软件，用法分两步：

运行后台容器作为服务器或启动现有的一个。
docker start rdesktop-nano

docker run -d --name rdesktop-nano -e 'RDESKTOP_OPTS=-k de -d MYDOMAIN -u johndoe' -e 'RDESKTOP_SERVER=172.10.1.1' desktopcontainers/rdesktop-nano

使用ssh -X（尽可能多的次数）连接到服务器。 登录后ssh自动打开一个rdesktop窗口

        ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
        -X app@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' rdesktop-nano)
