#!/bin/bash

mkdir -p /var/run/sshd

chown -R root:root /root

cd /usr/lib/web && ./run.py > /var/log/web.log 2>&1 &
nginx -c /etc/nginx/nginx.conf
exec /bin/tini -- /usr/bin/supervisord -n
