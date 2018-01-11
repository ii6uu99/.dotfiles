#!/bin/bash

USER=${USER:-admin}
PASSWORD=${PASSWORD:-admin}
LANG=${LANG:-en_US.UTF-8}
TIMEZONE=${TIMEZONE:-Etc/UTC}

echo ${TIMEZONE} > /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
dpkg-reconfigure locales
update-locale LANG=${LANG}

if [ ! -d /home/${USER} ] ; then
  useradd -m -k /etc/skel -s /bin/bash  ${USER}
  echo "${USER}:${PASSWORD}" |chpasswd
  usermod -a --group sudo ${USER}
  su -c "im-config -n scim" ${USER}
fi

#service xdm start
if [ -f /var/run/xdm.pid ] ; then
  rm /var/run/xdm.pid
fi
/usr/bin/xdm

service xinetd start

# Start the ssh service
/usr/sbin/sshd -D
