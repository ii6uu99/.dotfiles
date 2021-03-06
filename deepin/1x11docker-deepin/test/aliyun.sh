
#deepin配置阿里云镜像源
tee /etc/apt/sources.list <<-'EOF'
deb [by-hash=force] http://mirrors.aliyun.com/deepin unstable main contrib non-free 
deb-src http://mirrors.aliyun.com/deepin unstable main contrib non-free
EOF

#升级
apt-get update

apt-get install curl bash -y

####安装docker

#脚本来源 https://github.com/rancher/install-docker
#docker安装包来源,低版本会遇到dpkg无法安装docker-engine，
#出现dpkg: 处理软件包 docker-engine (--configure)时出错：
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/rancher/install-docker/master/1.11.2.sh)"

#curl -L https://raw.githubusercontent.com/rancher/install-docker/master/1.10.3.sh | sh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/rancher/install-docker/master/17.09.0.sh)"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/rancher/install-docker/master/17.03.0.sh)"


######################添加阿里云加速器###################################

#阿里云容器http://dev.aliyun.com/search.html

#使用国内阿里云加速镜像，下载docker官方镜像

#docker -v 客户端版本要大于1.10.0

#通过修改daemon配置文件/etc/docker/daemon.json来使用加速器：

mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://r2t47usc.mirror.aliyuncs.com"]
}
EOF
systemctl daemon-reload
systemctl restart docker

#将你的用户添加到docker组中
usermod -aG ming $USER

#拉取alpine
docker pull alpine

#显示docker服务状态
systemctl  status docker.service

