#!/bin/bash
## Description: Add defaults aliases for bash, configured to load .profile at top of .bash_profile for CURRENT user.

## HOW TO USE:
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/bash-defaults.sh | bash /dev/stdin


## Adds interactive, links, colors, and safe access for bash
/bin/echo -e "\n\
alias rm='rm -i'\n\
alias cp='cp -i'\n\
alias mv='mv -i'\n\
\n\
" > ~/.bashrc

/bin/echo -e "\n\
# User specific aliases and functions for links, colors, and safe access\n\
alias ls='ls --color=auto'\n\
alias ll='ls -la'\n\
alias l.='ls -d .* --color=auto'\n\
\n\
alias grep='grep --color=auto'\n\
alias egrep='egrep --color=auto'\n\
alias fgrep='fgrep --color=auto'\n\
\n\
alias rm='rm --preserve-root'\n\
alias chown='chown --preserve-root'\n\
alias chmod='chmod --preserve-root'\n\
alias chgrp='chgrp --preserve-root'\n\
\n\
" | tee -a ~/.bashrc
