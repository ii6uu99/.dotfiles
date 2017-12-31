#用法
	
	docker run -it --cap-add=NET_ADMIN --device /dev/net/tun --name openvpn-tap40 lihaixin/openvpn:pure /bin/sh -c "/sbin/ip addr add 172.17.0.140 dev eth0;  bash"

	openvpn GERMANY-TCP.ovpn &
