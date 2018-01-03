#https://github.com/abrahammouse/raspbian-aria-webui

# 使用rpi-raspbian作为基本的图像
FROM sdhibit/rpi-raspbian
MAINTAINER abrahammouse<abrahammouse@gmail.com>

# 更新存储库
RUN apt-get update \
        && apt-get install -y aria2 nginx \
        && rm -rf /var/lib/apt/lists/*

# 准备conf文件
RUN mkdir /data -p
RUN mkdir /aria2c -p
ADD aria2.session /aria2c/
ADD aria2.conf /aria2c/
ADD . /var/www/html/

# 公开端口
EXPOSE 6800 80

# 设置创建新容器时执行的默认命令
CMD service nginx restart && aria2c --conf-path=/aria2c/aria2.conf
