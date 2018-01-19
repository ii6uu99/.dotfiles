# .bash_profile: executed by bash for login shells.
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Docker (default for Vagrant based boxes)
export DOCKER_HOST=tcp://192.168.10.10:2375

