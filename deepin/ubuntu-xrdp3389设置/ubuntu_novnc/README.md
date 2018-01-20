https://github.com/mortiz/docker_ubuntu_novnc.git


什么是docker_ubuntu_novnc呢？
这是一个安装了x11vnc和novnc的Ubuntu zesty基本映像。它的目的是作为像Mate，KDE，xfce，i3等完整的桌面环境的基本形象。请参阅我的其他存储库的例子。

用法
Dockerfile

FROM rigormortiz/ubuntu_novnc:latest

...
值得注意的
监
这张图片是基于我的Ubuntu的的主管镜像，因此在主管上运行。基于这个镜像的桌面将需要发布一个类似于这个镜像的配置文件：（配偶）

[program:dbus]
priority=14
directory=/
command=dbus-launch
user=%(ENV_DESKTOP_USERNAME)s
autostart=true
autorestart=true

[program:mate]
priority=15
directory=/home/%(ENV_DESKTOP_USERNAME)s
command=/usr/bin/mate-session
user=%(ENV_DESKTOP_USERNAME)s
autostart=true
autorestart=true
environment=DISPLAY=":1",HOME="/home/%(ENV_DESKTOP_USERNAME)s"
暴露的端口
x11vnc在端口上暴露 5900
noVNC的HTTP接口暴露在端口上 6080
杂项。
默认用户是ubuntu。这可以通过DESKTOP_USERNAMEDockerfile中的变量进行更改
默认的VNC密码与当前相同DESKTOP_USERNAME。请参阅下一节中的TODO。它可以很容易地在运行时更改：
x11vnc -storepasswd somePassword /home/${DESKTOP_USERNAME}/.vnc/passwd
去做
支持SSL
动态生成VNC密码
