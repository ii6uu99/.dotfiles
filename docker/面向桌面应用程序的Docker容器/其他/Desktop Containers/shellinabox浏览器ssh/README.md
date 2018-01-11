https://github.com/atomney/shellinabox.git


# shellinabox
Shellinabox in an Ubuntu container

教程 https://www.jianshu.com/p/afec77178b67

 $ sudo apt-cache search shellinabox
    $ sudo apt-get install openssl shellinabox

$ sudo vi /etc/default/shellinabox
# shellinboxd的网络服务器监听的TCP端口
SHELLINABOX_PORT=6175

# 指定目标SSH服务器的IP地址。
SHELLINABOX_ARGS="--o-beep -s /:SSH:172.16.25.125"

# 如果您想要限制从本地主机访问shellinaboxd。
SHELLINABOX_ARGS="--o-beep -s /:SSH:172.16.25.125 --localhost-only"

启动服务
sudo service shellinaboxd start

查看是否启动
sudo netstat -nap | grep shellinabox



