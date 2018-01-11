https://github.com/tristann9/docker-nomachine-desktop.git


在Docker上将桌面（Lubuntu - LXDE）设置为SSH或NX的概念验证。概念脱离微服务。

建立
git clone https://github.com/tristann9/docker-nomachine-desktop.git
cd docker-nomachine-desktop
docker build -t=tristann9/docker-nomachine-desktop .
Docker拉取命令
docker pull tristann9/docker-nomachine-desktop
环境
USER - > SSH / NX登录用户

密码 - >用户密码

用法
docker run -d -p 4001:4000 -p 23:22 --name desktop -e PASSWORD=test -e USER=test --cap-add=SYS_PTRACE desktop
连
SSH
ssh test@localhost -p 23	
NoMachine（NX）
下载并安装NoMachine客户端：https：//www.nomachine.com/download

Download and Install NoMachine client: https://www.nomachine.com/download

Host/IP: Container Host

Port: 4001

User: test

Password: test



直接通过Docker
docker exec -it desktop bash
