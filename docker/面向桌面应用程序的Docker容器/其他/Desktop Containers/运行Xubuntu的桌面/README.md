运行Xubuntu的桌面
https://github.com/fdevillalobos/xubuntu_desktop


如何运行Xubuntu的桌面？
从码头工人索引中拉出并运行图像

```
CID=$(docker run -p 2222:22 -t -d [your_image_name])
docker logs $CID

note down the root/dockerx passwords.
```

如何使用客户端运行/连接到服务器？
载操作系统的x2go客户端
sudo apt-get install x2goclient

从http://wiki.x2go.org/doku.php/doc:installation:x2goclient下

创建一个新的会话并连接到您的服务器主机:(您的服务器IP）端口：2222用户名：根密码:(从泊坞日志中获取）

选择会话类型为：XFCE

你也可以用root或dockerx用户及其口令通过端口2222用linux ssh或windows putty客户端直接连接到docker容器。
