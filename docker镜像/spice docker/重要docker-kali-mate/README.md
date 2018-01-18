https://github.com/andrewkrug/docker-kali-mate.git

启动 kali mate

该容器从泊坞窗 - 卡利滚动继承基本容器。

＃容器包括以下内容：

Kali Linux Top 10
伴侣桌面
香料服务器
要使用这个容器，如果你不想自己构建它。

docker pull andrewkrug/kali-linux-mate:rolling
docker run -p 5900:5900 andrewkrug/kali-linux-mate:rolling
确保安装香料客户端。 apt-get install spice-client-gtk
连接到容器上的香料监听器。 spicy -h localhost -p 5900
