#在Linux系统上安装Compose
#https://docs.docker.com/compose/install/#upgrading

sudo rm /usr/local/bin/docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version


#下载目前的最新版：https://github.com/docker/compose/releases/tag/1.14.0-rc2

#docker-compose-Linux-x86_64
#rename docker-compose-Linux-x86_64 docker-compose
#cp docker-compose /usr/local/bin/
#chmod +x /usr/local/bin/docker-compose
#查看版本
#docker-compose version


#方法三： sudo apt-get install docker-compose

