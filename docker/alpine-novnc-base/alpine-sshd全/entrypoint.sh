#!/bin/ash

# generate host keys if not present
ssh-keygen -A

passwd -d root && \
echo "root:$ROOT_PASSWORD" | chpasswd
addgroup -g $GID $GROUP
adduser -D -h /home/$USERNAME -s /bin/bash -u $UID -G $GROUP $USERNAME
mkdir -p /home/$USERNAME/.ssh
echo "$USERNAME:PASSWORD" | chpasswd
sed -i s/#PubkeyAuthentication.*/PubkeyAuthentication\ yes/ /etc/ssh/sshd_config
sed -i s/#PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config
sed -i s/PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config
sed -i s/#LogLevel.*/LogLevel\ DEBUG/ /etc/ssh/sshd_config
echo "AllowGroups $GROUP" >> /etc/ssh/sshd_config

echo $PUBKEY > /home/$USERNAME/.ssh/authorized_keys
chown -Rf $USERNAME:$GROUP /home/$USERNAME/.ssh/
chmod 0700 /home/$USERNAME/.ssh/
chmod 0600 /home/$USERNAME/.ssh/authorized_keys


if [ -z ${MOTD+x} ]; then
    echo "setting motd"
    echo $MOTD > /etc/motd
fi

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
