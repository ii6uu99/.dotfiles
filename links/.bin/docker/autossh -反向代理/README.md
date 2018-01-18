autossh -反向代理

https://github.com/zaradoz/autossh-docker


一个Dockerfile并启动脚本来运行基于Alpine linux反向隧道的autossh。

在隧道中添加端口列表，每行使用openssh格式的一个隧道：

本地端口：远程主机：远程

即：
8080：本地主机：80

这一行将把码头容器上的罐8080 绑定到远程服务器上的端口80
