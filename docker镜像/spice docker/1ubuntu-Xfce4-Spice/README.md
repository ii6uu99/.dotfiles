https://github.com/gauthierc/DockerSpiceXfce4.git


## DockerSpiceLxde
这个库包含Dockerfile的Ubuntu桌面（XFCE4）为码头工人的

基地码头的形象
Ubuntu的：14.04
安装
安装Docker。

从公共Docker Hub注册表下载自动构建：docker pull gauthierc/dockerspicexfce4

（或者，你可以直接从Dockerfile图像：docker build -t="gauthierc/dockerspicexfce4" github.com/gauthierc/DockerSpiceXfce4）

用法
docker run -p 5900:5900 gauthierc/dockerspicexfce4
如果你的本地用户是'myusername'，你的uid是'1000'，你想在Docker中映射你的/ home / myusername：

docker run -p 5900:5900 -e SPICE_USER=myusername -e SPICE_UID=1000 -v /home/myusername:/home/myusername -e SPICE_PASSWD="azerty" -e SPICE_LOCAL="fr_FR.UTF-8" -e SPICE_RES="1366x768" gauthierc/dockerspicexfce4
通过Spice客户端连接

remote-viewer spice://localhost:5900

密码是 'password'.

