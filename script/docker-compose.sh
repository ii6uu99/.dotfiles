#在Linux系统上安装Compose
#https://docs.docker.com/compose/install/#upgrading

sudo rm /usr/local/bin/docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
