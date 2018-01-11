Ubuntu 16.04 + VNC
https://github.com/maurodelazeri/docker_ubuntu_desktop


Ubuntu 16.04的Docker容器包括ubuntu-desktop和vncserver。

如何运行
docker run -p 5901:5901 queeno/ubuntu-desktop

然后连接到：

vnc://<host>:5901 通过VNC客户端。

VNC密码是password。
