# dockerdesktopnovnc
https://github.com/atomney/dockerdesktopnovnc

This is an Ubuntu 16.04 desktop with XFCE4 and NOVNC in a docker container.
这是一个在Docker容器中使用XFCE4和NOVNC的Ubuntu 16.04桌面。

说明
获取码头图像
如果你想自己构建它。

git clone https://github.com/atomney/dockerdesktopnovnc.git
cd dockerdesktopnovnc
docker build -t atomney/dockerdesktopnovnc .
你也可以在没有建筑的情况下拉它

docker pull atomney/dockerdesktopnovnc
运行泊坞窗图像
docker run -td -v /etc/localtime:/etc/localtime:ro -p 80:6080 atomney/dockerdesktopnovnc
还有一个包含上述命令的包含脚本。

chmod +x desktop.sh
./desktop.sh --start
访问noVNC接口
如果您使用我的启动脚本作为您的容器，它将在端口80上进行侦听只需将您的浏览器指向：

HTTP：// yourdockerhost
