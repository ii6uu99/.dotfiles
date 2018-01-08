PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

VOLUME_BASE=/data/samba
S_HOST=samba
S_DEV=eth0
S_DOMAIN=out.ba
S_HOST_IP=192.168.1.1
S_DNS_HOST_IP=192.168.1.1


sudo ip addr show | grep $S_HOST_IP |
sudo ip addr add $S_HOST_IP/24 dev $S_DEV

docker rm -f $S_HOST.$S_DOMAIN


docker run -d -it \
--name $S_HOST.$S_DOMAIN \
-h $S_HOST.$S_DOMAIN \
-p $S_HOST_IP:138:138/udp \
-p $S_HOST_IP:139:139 \
-p $S_HOST_IP:445:445 \
-p $S_HOST_IP:445:445/udp \
-e SMB_USER='admin' \
-e SMB_PASS='password' \
-v $VOLUME_BASE/arhiva:/data/samba/arhiva \
-v $VOLUME_BASE/config/smb.conf:/etc/samba/smb.conf \
appcontainers/samba
