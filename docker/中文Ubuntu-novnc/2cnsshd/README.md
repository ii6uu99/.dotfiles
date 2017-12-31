## sshd介绍

基于ubuntu:16.04 配置sshd服务和基本的网络工具包和中文字体

## 用法

###运行容器

	docker run -d -p <PORT>:22 --name sshd lihaixin/sshd

###修改root密码

	docker exec -it sshd /bin/sh -c "echo 'root:PASSWORD' | chpasswd"


