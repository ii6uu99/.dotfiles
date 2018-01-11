https://github.com/neilcawse/Docker-Ubuntu-Unity-noVNC


适用于Ubuntu的Dockfile与Unity桌面环境和noVNC。

此图片/ Dockerfile旨在为创建容器的Ubuntu 16.04与统一的桌面，并使用TightVNCServer，noVNC，Ngrok（可选），它允许用户使用浏览器登录到这个容器中。

如何使用？
你可以自己构建这个Dockerfile：

sudo docker build -t "chenjr0719/ubuntu-unity-novnc" .
或者，拉我的形象：

sudo docker pull chenjr0719/ubuntu-unity-novnc
这个图像的默认使用是：

sudo docker run -itd -p 80:6080 chenjr0719/ubuntu-unity-novnc
等待几秒钟，您可以访问http：//localhost/vnc.html并查看此屏幕：

替代文字

密码
默认情况下，密码将随机创建，找到密码，请使用以下命令：

sudo docker exec $CONTAINER_ID cat /home/ubuntu/password.txt
您可以使用此密码登录到此容器。

登录后，你可以看到这个屏幕：

替代文字

参数
这个图像包含3个输入参数：

密码

您可以根据自己的喜好设置自己的用户密码：

sudo docker run -itd -p 80:6080 -e PASSWORD=$YOUR_PASSWORD chenjr0719/ubuntu-unity-novnc
现在，您可以使用自己的密码登录。

须藤

默认情况下，用户ubuntu不会成为sudoer，但是如果你需要，你可以使用这个命令：

sudo docker run -itd -p 80:6080 -e SUDO=yes chenjr0719/ubuntu-unity-novnc
这个命令将授予用户ubuntu的sudo。

并且使用SUDO = YES，SUDO =是，SUDO = Y，SUDO = y也被支持。

要检查sudo是否正常工作，在打开xTerm时应该显示以下消息：

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
替代文字

警告！！允许你的用户作为sudoer可能会导致安全问题，慎重使用它。

Ngrok

Ngrok可以用来部署localhost到互联网。

如果你需要在互联网上使用这个图像，Ngrok是你所需要的。

要启用Ngrok，请使用以下命令：

sudo docker run -itd -p 80:6080 -e NGROK=yes chenjr0719/ubuntu-unity-novnc
并找到链接地址：

sudo docker exec $CONTAINER_ID cat /home/ubuntu/ngrok/Ngrok_URL.txt
NGROK = YES，NGROK =是，NGROK = Y，NGROK = y也被支持。

警告！！这也可能导致安全问题，慎重使用。

屏幕尺寸
屏幕大小的默认设置是1600x900。

您可以使用以下命令更改屏幕，这会将屏幕大小更改为1024x768：

sudo docker exec $CONTAINER_ID sed -i "s|-geometry 1600x900|-geometry 1024x768|g" /etc/supervisor/conf.d/supervisor.conf
sudo docker restart $CONTAINER_ID
问题
用gnome-terminal无法正常工作，请使用XTerm来放置它。

Unity的某些组件可能无法正常使用vncserver。
