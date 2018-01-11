https://github.com/maple52046/mate-container

Ubuntu Mate桌面容器
这个项目可以帮助你用Desktop环境（Ubuntu Mate）构建和运行一个Docker容器。

Prerequiresuite
在你的机器上安装Docker
建立图像
docker build -t ubuntu-mate:14.04 .
注：您可以通过修改Dockerfiles来更改Ubuntu的版本。

X11VNC
如果您想使用X11VNC为此容器提供VNC服务器。您需要编译并安装X11VNC（0.9.14）的beta版本。

有两种方法：

方法1：执行docker build image时编译并安装X11VNC
执行脚本文件：

bash build-x11vnc.sh
该脚本将下载X11VNC 0.9.14版本的源代码，并编译成为deb文件。

然后，您需要在Dockerfiles中取消注释以下行：

COPY x11vnc-0.9.14/x11vnc_0.9.14-1_amd64.deb /tmp/x11vnc_0.9.14-1_amd64.deb
RUN (dpkg -i /tmp/x11vnc_0.9.14-1_amd64.deb || apt-get install -f) && rm /tmp/x11vnc_0.9.14-1_amd64.deb
现在，docker build image时会安装X11VNC。

方法2：在容器中编译并安装X11VNC
您可以将脚本复制build-x11vnc.sh到您的容器中，然后执行脚本来构建deb文件。然后用命令安装它sudo "dpkg -i /tmp/x11vnc_0.9.14-1_amd64.deb || apt-get install -f"

创建/运行一个容器
docker run -d --privileged --net default --name mate --hostname mate ubuntu-mate:14.04 /sbin/init
docker exec -it mate useradd -m -s /bin/bash -G sudo myuser
docker exec -it mate passwd myuser
docker exec -d mate service lightdm restart
如果你安装了X11VNC，你可以用docker exec命令启动守护进程：

docker exec -d mate x11vnc -auth guess -scale 1024x768 -forever
注：也许你会需要增加-p 5900:5900在docker run ....出口VNC端口。

问题
启动lightdm后，tty7将显示登录窗口。如果您的输入设备（鼠标，键盘）不起作用，则需要拔下设备的USB插口并重新插上。
