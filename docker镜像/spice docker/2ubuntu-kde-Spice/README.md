https://github.com/donbowman/kde-docker.git


## kde-docker
这个库包含kde-docker，Ubuntu 16.04 + kde neon，使用spice作为显示。

香料的网络客户端可能会对您的KDE桌面提供基于网络的访问。

它明确禁用合成来获得更好的感知性能，但可以随时重新启用和试验。

来自DockerSpiceXfce4的灵感

基地码头的形象
Ubuntu的的：16.04
安装
docker build -t="donbowman/kde-docker" github.com/donbowman/kde-docker
用法
docker run -p 5900:5900 donbowman/kde-docker
如果您在已经运行kde的主机上运行此命令，则可能需要不同的〜/ .config。mkdir〜/ .config-kde-docker并挂载它。

如果你的本地用户是'myusername'，你的uid是'1000'，你想在Docker中映射你的/ home / myusername：

docker run --name kde -p 5900:5900 -e SPICE_USER=myusername -e SPICE_UID=1000 -v /home/myusername:/home/myusername -e -v /home/myusername/.config-kde-docker:/home/myusername/.config SPICE_PASSWD="password" -e SPICE_LOCAL="en_CA.UTF-8" -e SPICE_RES="1920x1080" donbowman/kde-docker
一个简单的方法来创建一个“你”的容器是：

docker run --name kde -p 5900:5900 -e SPICE_USER=$(whoami) -e SPICE_UID=$(id -u) -v $HOME:/home/$(whoami) -v $HOME/.config-kde-docker:$HOME/.config -e SPICE_PASSWD="password" -e SPICE_LOCAL="en_CA.UTF-8" -e SPICE_RES="1920x1080" donbowman/kde-docker
通过辣妹客户端连接

    spicy -h localhost -p 5900

The default password is 'password'.

