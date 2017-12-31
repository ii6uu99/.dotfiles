OpenSSH连接上alpine

使用这个Dockerfile / -image在一个轻量级的Alpine容器上启动一个sshd-server。

特征

总是安装最新的可用于Alpine的OpenSSH版本
使用--env启动容器时，可以更改“root”用户的密码
基本用法

$ docker run --rm \
--publish=1337:22 \
--env ROOT_PASSWORD=MyRootPW123 \
hermsi/alpine-sshd
容器启动后，您可以以root用户的身份在“root”用户中输入密码。

$ ssh root@mydomain.tld -p 1337
用于docker-compose

我建立了这个图像，以便使用它与一个nginx和fpm-php容器通过sftp传输文件。如果你对满足这个需求的Dockerfile感兴趣：这样
