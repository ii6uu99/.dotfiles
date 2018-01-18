https://github.com/gauthierc/DockerSpiceLxde.git


## DockerSpiceLxde
这个库包含Dockerfile的Ubuntu桌面（LXDE）为码头工人的

基地码头的形象
Ubuntu的：14.04
安装
安装Docker。

从公共Docker Hub注册表下载自动构建：docker pull gauthierc/dockerspicelxde

（或者，你可以直接从Dockerfile图像：docker build -t="gauthierc/dockerspicelxde" github.com/gauthierc/DockerSpiceLxde）

用法
docker run -p 5900:5900 gauthierc/dockerspicelxde
如果你的本地用户是'myusername'，你的uid是'1000'，你想在Docker中映射你的/ home / myusername：

docker run -p 5900:5900 -e SPICE_USER=myusername -e SPICE_UID=1000 -v /home/myusername:/home/myusername gauthierc/dockerspicelxde
通过Spice客户端连接“spicec -h localhost -p 5900”
