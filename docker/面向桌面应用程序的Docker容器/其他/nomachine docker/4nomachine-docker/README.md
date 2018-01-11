https://github.com/it-kombinat/nomachine-docker

在容器中运行NOMACHINE

如何在泊坞窗中运行NoMachine服务器第4节考虑到泊坞窗安装在主机上，要在泊坞窗中运行NoMachine服务器，从Dockerfile构建映像并启动它就足够了。

例如，使用MATE作为桌面环境构建一个图像：

创建你的图像目录，例如
mkdir nomachine

将以下Dockerfile的内容复制到：nomachine / Dockerfile。
根据需要调整Dockerfile。

将下面的包装器脚本的内容复制到：nomachine / nxserver.sh。
并设置可执行权限：

chmod + x nomachine / nxserver.sh

建立图像：

docker build -t=nomachine nomachine

5) 运行容器：

docker run -d -p 4000:4000  nomachine

根据需要设置不同的端口（请参见下面的d和ë点）。

您可以通过重复-p选项指定多个端口，例如

docker run -d -p 4000:4000 -p 22:22

Dockerfile for NoMachine Workstation v. 4 for evaluation

The Dockerfile you have already downloaded the NoMachine package v. 4.

It uses the following NoMachine Workstation package for evaluation: nomachine-workstation-evaluation_4.6.22_2_amd64.deb and it is just an example that can be easily adapted to whichever other package you want to try.

一）将包的名称替换为您要运行的服务器的名称。请注意，总是要求服务器包装脚本。

B）中默认情况下，它将运行MATE桌面环境，您可以通过将“伴侣桌面环境核”替换为您选择的桌面来进行调整。

C）中它将以nomachine作为密码创建nomachine用户，您可以指定不同的用户名和密码，并重复说明以创建其他用户。

d）“EXPOSE 4000”命令打开端口4000，这是NX协议连接的默认端口。如果您打算使用SSH协议连接，请设置“EXPOSE 22” 。

e）默认情况下，网络使用端口4080和4443进行连接。添加“EXPOSE 4080 4443”让用户运行网络会话。这仅适用于NoMachine Cloud Server。
