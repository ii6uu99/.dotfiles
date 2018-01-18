https://github.com/shugaoye/docker-spice.git



Spice Docker构建环境
Spice在Ubuntu 14.04中构建环境。

如何建立它
Makefile中有两个目标（aosp和test）。要构建它，只需检出存储库并运行以下命令：$ make

如何测试它
你可以使用下面的命令来测试它。$ make测试
$ docker run -v "$(VOL1):/root" -v "$(VOL2):/tmp/ccache" -it -e USER_ID=$(id -u) -e GROUP_ID=$(id -g) $(IMAGE) /bin/bash

它将设置两个数据卷
VOL1 - 构建工作目录
VOL2 -缓存目录
您可以使用环境变量定义您自己的用户和组，也可以在容器中设置当前用户
