x11docker / deepin

在Docker中运行deepin桌面。

使用x11docker来运行图像。
从github获取x11docker：https：//github.com/mviereck/x11docker
运行桌面：

x11docker --desktop --systemd --pulseaudio x11docker/deepin
运行单个应用程序

x11docker x11docker/deepin deepin-terminal
选项：

您可以添加硬件加速选项 --gpu
您可以使用选项创建持久的主文件夹 --home
请参阅x11docker --help更多选项。

![screenshot](https://raw.githubusercontent.com/mviereck/x11docker/screenshots/screenshot-deepin.png "deepin desktop running in weston Xwayland window using x11docker")
