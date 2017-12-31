#!/bin/sh

mkdir -p /usr/local/vpnserver/config

ln -s /usr/local/vpnserver/config/vpn_server.config \
      /usr/local/vpnserver/vpn_server.config

if [ ! -d "/var/log/vpnserver/security_log" ]; then
  mkdir -p /var/log/vpnserver/security_log
  sleep 2
fi

if [ ! -d "/var/log/vpnserver/packet_log" ]; then
  mkdir -p /var/log/vpnserver/packet_log
  sleep 2
fi

if [ ! -d "/var/log/vpnserver/server_log" ]; then
  mkdir -p /var/log/vpnserver/server_log
  sleep 2
fi

/usr/local/vpnserver/vpnserver start
sleep 2

tail -F /usr/local/vpnserver/*_log/*.log &
sleep 2

/sbin/ip address add 172.16.0.1/24 brd + dev tap_default
sleep 2
iptables -t nat -D POSTROUTING -s 172.16.0.0/24 -j MASQUERADE
sleep 2
iptables -t nat -A POSTROUTING -s 172.16.0.0/24 -j MASQUERADE
sleep 2

service dnsmasq  start

set +e
while pgrep vpnserver > /dev/null; do sleep 1; done
set -e
