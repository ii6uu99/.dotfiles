https://github.com/ryankurte/docker-rpi-emu
树莓派的Docker仿真环境

# Docker emulation environment for Raspberry Pi
在Docker容器中运行Raspberry Pi应用程序

uname -a 查看系统的环境

## Usage

主机docker，必须安装qemu。使用Docker for Mac的主机环境包括这个标准（OSX docker-machines但是不包含qemu），在Debian中，您将需要安装qemu和qemu-user-static软件包。

### 自己构建



1. git clone git@github.com:ryankurte/docker-rpi-emu.git` check out this repository
2. cd docker-rpi-emu` to change into the directory
3. make run-emu` to launch the emulated environment

这将从raspberrypi.org引导Raspbian图像，建立码头图像，并启动仿真环境。

### From Dockerhub
要开始使用Docker，请首先使用图像拖动图像docker pull ryankurte/docker-rpi-emu。

确保你有一个Raspbian图像（你可能想要备份它，它会被模拟环境中的任何东西修改），然后运行下面的命令。

`docker run -it --rm --privileged=true -v IMAGE_LOCATION:/usr/rpi/images -w /usr/rpi ryankurte/docker-rpi-emu /bin/bash -c './run.sh images/IMAGE_NAME [COMMAND]'`  

其中，IMAGE_LOCATION是包含要挂载的Raspbian图像的目录，IMAGE_NAME是要使用的图像的名称，[COMMAND]是要执行的可选命令（在图像内）。
例如：
`docker run -it --rm --privileged=true -v /Users/ryan/projects/docker-rpi-emu/images:/usr/rpi/images -w /usr/rpi ryankurte/docker-rpi-emu /bin/bash -c './run.sh images/2016-05-27-raspbian-jessie-lite.img /bin/bash'`  

将挂载图像目录/Users/ryan/projects/docker-rpi-emu/images和图像，2016-05-27-raspbian-jessie-lite.img然后/bin/bash在模拟环境中运行该命令。

组件
码头集装箱包括所需的Qemu组件来支持仿真。这必须在特权模式下启动，以允许安装回送设备。

该容器还包含一组脚本，用于简化安装到/usr/rpi设备目录中的Qemu环境的加载/定制/启动/卸载。

命令
命令被安装到/usr/rpidocker镜像的目录中。

./mount.sh IMAGE DIR识别映像中的分区大小，并将raspbian映像安装到DIR（根和分区）指定的位置。
./unmount.sh DIR使用上面的脚本卸载安装到DIR的两个分区。
./qemu-setup.sh DIR在由DIR指定的挂载点处将Qemu组件添加到图像。
./qemu-cleanup.sh DIR从DIR指定的挂载点的映像中删除Qemu组件。
./qemu-launch.sh DIR从DIR指定的目录运行Qemu实例，将
./run.sh IMAGE [COMMAND]所有上述命令连接在一起，以简化使用提供的IMAGE和可选COMMAND执行的仿真环境。

如果您有任何问题，意见或建议，请随时打开问题或拉取请求。
