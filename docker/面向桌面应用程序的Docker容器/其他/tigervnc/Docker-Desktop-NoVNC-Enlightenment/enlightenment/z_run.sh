docker run --rm -i -p 5901:5901 -p 8082:80 -p 8443:443 -v /opt/downloads/:/home/user/Downloads/ -e VNC_PW=pass123 shrek/ubuntu-enlightenment
