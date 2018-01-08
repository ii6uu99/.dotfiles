# 在Ubuntu 14.04.4 x64上安装Docker
# 脚本在Ubuntu上安装Docker引擎1.12
# No interactive for now.
export DEBIAN_FRONTEND=noninteractive
# 更新您的APT包索引。
sudo apt-get -y update
# 更新软件包信息，确保APT使用https方法，并且安装了CA证书。
sudo apt-get -y install apt-transport-https ca-certificates
# 添加新的GPG密钥。
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
# 添加docker.list
sudo echo "deb https://apt.dockerproject.org/repo ubuntu-trusty experimental" > /etc/apt/sources.list.d/docker.list
# 更新您的APT包索引。
sudo apt-get -y update
# 清除旧的回购，如果它存在。
sudo apt-get purge lxc-docker
# 确认APT正在从正确的版本库中提取。
sudo apt-cache policy docker-engine
# 安装推荐的软件包。
sudo apt-get -y install linux-image-extra-$(uname -r)
#  Ubuntu的14.04或12.04，则需要AppArmor的。
sudo apt-get -y install apparmor
# 安装Docker。
sudo apt-get -y install docker-engine
#启动docker守护进程。
sudo service docker start
# 验证码头版本
docker -v
