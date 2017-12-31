# lihaixin/docker-softether-vpnserver

Softether VPN Server for Linux
https://www.softether.org

## Usage

```

docker run -d --name=softether-vpnserver \
--net=host --privileged --name softether-vpnserver \
lihaixin/docker-softether-vpnserver
```
Admin Password: softether

## Extra Options


```
wget -O /etc/vpn_server.config https://github.com/lihaixin2/docker-softether-vpnserver/raw/master/vpn_server_self.config
docker run -d --name=softether-vpnserver \
--net=host --privileged \
-v /etc/vpn_server.config:/usr/local/vpnserver/vpn_server.config \
lihaixin/docker-softether-vpnserver
```
