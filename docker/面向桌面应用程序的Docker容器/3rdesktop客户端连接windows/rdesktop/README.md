https://github.com/DesktopContainers/rdesktop


rdesktop的

功能齐全的rdesktop Docker容器。

它基于DesktopContainers / base-mate

用法：运行客户端
它使用与底层vnc服务器相同的屏幕分辨率

环境变量和默认值
RDESKTOP_SERVER
将其设置为rdp服务器地址
RDESKTOP_OPTS
默认没有设置使用这个来设置rdesktop的选项。请参阅rdesktop的命令行选项
简单的SSH X11转发
由于它是一个X11 GUI软件，用法分两步：

1运行后台容器作为服务器或启动现有的一个。

        docker start rdesktop-nano 

docker run -d --name rdesktop-nano -e 'RDESKTOP_OPTS=-k de -d MYDOMAIN -u johndoe' -e 'RDESKTOP_SERVER=172.10.1.1' desktopcontainers/rdesktop-nano
        
  2.使用ssh -X（尽可能多的次数）连接到服务器。 登录后ssh自动打开一个rdesktop窗口

        ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
        -X app@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' rdesktop-nano)
