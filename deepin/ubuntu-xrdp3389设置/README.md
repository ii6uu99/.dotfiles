https://github.com/mortiz/docker-ubuntu-xrdp



docker-ubuntu-xrdp是什么？
Docker-ubuntu-xrdp是安装了xrdp的Ubuntu Zesty的基础镜像。它是基于Docker的桌面环境（如Mate）在RDP上运行的基础映像。

如何使用这个图像
你通常不想自己运行这个图像。你可以将它用作Dockerfile中的“FROM”。

例如：

FROM rigormortiz/ubuntu-xrdp:zesty

