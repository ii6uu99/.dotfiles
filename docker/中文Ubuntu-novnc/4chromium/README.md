## chromium介绍

基于ubuntu:16.04 配置x11和novnc 服务和中文字体,在容器里运行chromium 游览器,已经配置支付flash播放

## 用法

###运行容器

	docker run -d -p 5900:5900 -p 8787:8787 --name chromium lihaixin/chromium

###修改VNC密码

	docker exec -it chromium /bin/sh -c "x11vnc -storepasswd VNCPASSWORD ~/.vnc/passwd"


###如何访问

	firefox http://<IP>:8787

	vncviewer <IP>:5900

