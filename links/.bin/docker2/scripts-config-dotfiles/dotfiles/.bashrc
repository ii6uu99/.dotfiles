# .bashrc

# User specific aliases and functions
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin:/usr/local/sbin:/home/boret/sbin

  # Adndroid  development kit definitions
#  export M2_HOME=/usr/local/apache-maven/apache-maven-3.2.1
#  export M2=$M2_HOME/bin
#  export ANDROID_HOME=/home/boret/android-sdk-linux
#  PATH=$M2:$ANDROID_HOME:$PATH

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Alias
alias ls="ls --color=auto"

# Set readline mode to vim [boret]
set -o vi

#export TERM="screen.xterm-256color"
export TERM="xterm-termite"
# Activamos un "prompt" coloreado
color_prompt=yes
force_color_prompt=yes
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;34m\]@\[\033[01;34m\]\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '

# Para mostrar "branches" en repos git, en el prompt
function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
}
function proml {
	local        BLUE="\[\033[0;34m\]"
	# OPTIONAL - if you want to use any of these other colors:
	local         RED="\[\033[0;31m\]"
	local   LIGHT_RED="\[\033[1;31m\]"
	local       GREEN="\[\033[0;32m\]"
	local LIGHT_GREEN="\[\033[1;32m\]"
	local       WHITE="\[\033[1;37m\]"
	local  LIGHT_GRAY="\[\033[0;37m\]"
	# END OPTIONAL
	local     DEFAULT="\[\033[0m\]"
#	PS1="\h:\W \u$BLUE\$(parse_git_branch) $DEFAULT\$"
	PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;34m\]@\[\033[01;34m\]\h\[\033[00m\]:\[\033[01;34m\]\w$BLUE\$(parse_git_branch) \$\[\033[00m\] "
}
proml


source ~/.xsh


# added by travis gem
[ -f /home/boret/.travis/travis.sh ] && source /home/boret/.travis/travis.sh
