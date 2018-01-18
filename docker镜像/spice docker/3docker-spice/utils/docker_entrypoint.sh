#!/bin/bash
set -e

if [ -z ${USER_ID+x} ]; then USER_ID=1000; fi
if [ -z ${GROUP_ID+x} ]; then GROUP_ID=1000; fi

# ccache
export CCACHE_DIR=/tmp/ccache
export USE_CCACHE=1

msg="docker_entrypoint: Creating user UID/GID [$USER_ID/$GROUP_ID]" && echo $msg
groupadd -g $GROUP_ID -r aosp && \
useradd -u $USER_ID --create-home -r -g aosp aosp
echo "$msg - done"

# Enable sudo for aosp
echo "aosp ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

/usr/sbin/sshd -D &

msg="docker_entrypoint: Creating /tmp/ccache and /home/aosp directory" && echo $msg
mkdir -p /tmp/ccache
chown aosp:aosp /tmp/ccache
echo "$msg - done"

echo ""

# Default to 'bash' if no arguments are provided
args="$@"
if [ -z "$args" ]; then
  args="bash"
fi

# Execute command as `aosp` user
export HOME=/home/aosp
echo "args=$args"
exec sudo -E -u aosp $args --init-file /root/bash.bashrc
