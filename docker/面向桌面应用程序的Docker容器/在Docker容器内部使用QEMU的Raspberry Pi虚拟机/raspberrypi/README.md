https://github.com/DesktopContainers/raspberrypi.git

树莓派
树莓派虚拟机在Qemu

这是一个容器，用来模拟qemu模仿覆盆子pi里的raspbian lite分布。

你可以通过ssh -X / VNC / noVNC（http）获得QEMU窗口。您也可以直接连接到2222端口上的qemu树莓。

您只能连接一个容器。如果您需要多个raspberrys，请多次运行docker容器。

您可以通过将音量/图像挂载到持久卷上来保留图像。此外，如果你用的名称QEMU修补树莓派形象为它供给raspberry.img QEMU将启动这一形象的时候了。

注意：如果你使用ssh -X来获得qemu窗口 - qemu覆盆子的运行实例将被杀死并重新启动（这需要一些时间），如果你想用gui覆盖树莓，最好使用novnc或者vnc

Docker Healthcheck检查树莓的ssh是否可达

它基于DesktopContainers / base-mate

用法：运行客户端
简单的SSH X11转发
您可以通过ssh连接到qemu raspberry rasbian系统或获取qemu X11 GUI，以下是您如何使用它：

运行后台容器作为服务器或启动现有的一个。



        docker start raspberrypi || 

docker run -d --name raspberrypi -p 2222:2222 -p 80:80 -p 443:443 --privileged desktopcontainers/raspberrypi
     
2.1通过ssh直接连接到qemu树莓。（注意码头健康检查状态 - ssh在健康时可用）
  
        ssh -p 2222 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no pi@localhost
        
2.2查看http：// localhost上的qemu环境（窗口）

选项和配置
卷

* __/images__ 地方，树莓派图像将被存储为 raspberry.img


### Exposed Ports

* 2222为ssh连接到qemu覆盆子pi（raspbian lite）

密码
用户： pi
密码：覆盆子
环境变量和默认值
FS_EXTEND_GB
默认：8 - 可以是任何数字来增加rootfs的fs大小。
RC_LOCAL_COMAND
没有默认 - bash命令包含在rc.local中

