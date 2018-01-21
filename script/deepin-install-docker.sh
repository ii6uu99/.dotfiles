#deepin官网安装docker
#https://wiki.deepin.org
#deepin官网安装docker   https://wiki.deepin.org/index.php?title=Docker

#卸载以前版本
sudo apt-get remove docker docker-engine

#安装必备工具
sudo apt-get install apt-transport-https ca-certificates curl python-software-properties software-properties-common

#下载并安装密钥
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#查看密钥是否安装成功
sudo apt-key fingerprint 0EBFCD88

#添加docker官方仓库
#cat /etc/debian_version，再根据版本号对应的代号替换上面命令的wheezy即可
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian wheezy stable"

#更新仓库
sudo apt-get update

#安装docker-ce
sudo apt-get install docker-ce

查看安装的版本信息
docker version

验证docker是否被正确安装并且能够正常使用
sudo docker run alpine


sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker



#添加docker组
sudo groupadd docker
#将用户加入该 group 内。然后退出并重新登录就生效啦。
sudo gpasswd -a ${USER} docker
#重启 docker 服务
sudo service docker restart
#切换当前会话到新 group 或者重启 X 会话
newgrp - docker



#禁止开机自启
#默认情况下Docker是开机自启的，如果我们想禁用开机自启，可以通过安装chkconfig命令来管理Deepin自启项

# 安装chkconfig
#sudo apt-get install chkconfig

# 移除自启
#sudo chkconfig --del docker















