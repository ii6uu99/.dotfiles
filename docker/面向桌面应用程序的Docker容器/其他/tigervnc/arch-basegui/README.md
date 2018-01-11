https://github.com/binhex/arch-basegui.git

应用

Arch Linux

描述

Arch Linux是一个独立开发的i686 / x86-64通用GNU / Linux版本，通用性足以适应任何角色。开发的重点是简单，简约和代码优雅。

构建笔记

使用binhex存储库中的 “arch-scratch”图像构建Arch Linux基本映像。此映像通过使用archive.archlinux.org网站进行软件包更新设置为快照，因此需要通过防止滚动更新到软件包来减少映像大小。

通过Web界面访问（noVNC）

http://<host ip>:<host port>/vnc.html?resize=remote&host=<host ip>&port=<host port>&&autoconnect=1

例如：-

http://192.168.1.10:6080/vnc.html?resize=remote&host=192.168.1.10&port=6080&&autoconnect=1

通过VNC客户端访问

<host ip>::<host port>

例如：-

192.168.1.10::5900

笔记

这个映像包含Tini（https://github.com/krallin/tini），以确保干净的关闭和正确收获进程，还安装了Supervisor（http://supervisord.org/）来帮助监视和运行子进程。

如果你喜欢我的工作，那么请考虑给我买一瓶啤酒：D


