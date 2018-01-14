To gain access to a VirtualBox shared folder, add it as read/write capable folder fron the host system in the box's admin panel then...

sudo adduser xxxxxxx vboxsf

## Generating a key with no passphrase.
ssh-keygen -b 2048 -t rsa -f /tmp/sshkey -q -N ""
