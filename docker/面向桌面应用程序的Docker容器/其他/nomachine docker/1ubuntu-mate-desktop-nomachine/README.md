https://github.com/cesarandreslopez/docker-ubuntu-mate-desktop-nomachine.git

Ubuntu Desktop 16.04（MATE）Dockerfile，带有NoMachine远程访问和firefox，libreoffice和tor-browser

如何运行
建立
git clone https://github.com/cesarandreslopez/docker-ubuntu-mate-desktop-nomachine.git
cd docker-ubuntu-mate-desktop-nomachine
docker build -t=cesarandreslopez/docker-ubuntu-mate-desktop-nomachine .
Docker拉取命令
docker pull cesarandreslopez/docker-ubuntu-mate-desktop-nomachine
环境的可能性
用户 - >用户为nomachine登录密码 - >密码为nomachine登录

用法
docker run -d -p 4000:4000 --name desktop -e PASSWORD=password -e USER=user --cap-add=SYS_PTRACE cesarandreslopez/docker-ubuntu-mate-desktop-nomachine
连接到容器
从https://www.nomachine.com/download下载NoMachine客户端，安装客户端，创建一个新的连接到您的公共IP，端口4000，NX协议，使用环境用户和密码进行身份验证（确保设置环境这个变量）
