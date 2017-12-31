# Cyril Robin's ~/.zshrc
# Inspired from oh-my-zsh template
# and Alexis de Lattre (http://formation-debian.via.ecp.fr/)

# 这个dotfiles路径的＃快捷方式是$ ZSH
export ZSH=$HOME/.dotfiles/links/.zsh
source $ZSH/env.zsh
source $ZSH/path.zsh
source $ZSH/prompt.zsh
source $ZSH/window.zsh
source $ZSH/aliases.zsh
source $ZSH/config.zsh

#alias分类
source $ZSH/a-docker.zsh
source $ZSH/a-fun.zsh
source $ZSH/a-git.zsh
source $ZSH/a-other.zsh
source $ZSH/a-tmux.zsh
source $ZSH/a-vagrant.zsh
source $ZSH/a-vim.zsh

#函数分类
source $ZSH/f-docker.zsh
source $ZSH/f-git.zsh
source $ZSH/f-other.zsh
source $ZSH/f-vagrant.zsh
source $ZSH/f-vim.zsh


#加载函数
for f in $(find ~/.dotfiles/links/.zsh/functions/ -type f); do
	source $f
done

fpath=(~/dotfiles/links/.zsh/bin ~/.dotfiles/links/.zsh/functions $fpath)

# 加载任何机器特定的配置和环境变量
if [[ -a ~/.localrc ]]; then
  source ~/.localrc
fi

#在这里初始化自动完成，否则函数将不会被加载
autoload -U compinit
compinit



[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
[ -f ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[ -f ~/.vim/bundle/fzf/shell/completion.zsh ] && source ~/.vim/bundle/fzf/shell/completion.zsh 2> /dev/null
[ -f ~/.vim/bundle/fzf/shell/key-bindings.zsh ] && source ~/.vim/bundle/fzf/shell/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

################
# 0. Oh-My-ZSH #
################

#你的oh-my-zsh配置的路径
ZSH=$HOME/.zsh/oh-my-zsh

#设置要加载的主题的名称
# Look in ~/.oh-my-zsh/themes/
#ZSH_THEME="robbyrussell"
#ZSH_THEME="aussiegeek"
#ZSH_THEME="avit"
#ZSH_THEME="bira"
#ZSH_THEME="blinks"
#ZSH_THEME="candy"
#ZSH_THEME="clean"
ZSH_THEME="cyrobin"
source ~/.dotfiles/links/.zsh/theme-choice

#自定义插件可能被添加到〜/ .oh-my-zsh / custom / plugins /
#格式示例：plugins =（rails git textmate ruby​​ lighthouse）
plugins=(aws
         bundler
         capistrano
         composer
         git
         git-extras
         git-flow
         gem
         golang
         history-substring-search
         marked
         npm
         rails
         rvm
         safe-paste
         tmux
         tmuxinator
         vagrant
         yarn
         z
         zaw
         zsh-output-highlighting
         zsh-syntax-highlighting)




#######################################
# 2. Définition des touches #
#######################################

# Use vim keybindings
# (put this before the other bindings to avoid overwriting)
bindkey -v

# Exemple : ma touche HOME, cf  man termcap, est codifiee K1 (upper left
# key  on keyboard)  dans le  /etc/termcap.  En me  referant a  l'entree
# correspondant a mon terminal (par exemple 'linux') dans ce fichier, je
# lis :  K1=\E[1~, c'est la sequence  de caracteres qui sera  envoyee au
# shell. La commande bindkey dit simplement au shell : a chaque fois que
# tu rencontres telle sequence de caractere, tu dois faire telle action.
# La liste des actions est disponible dans "man zshzle".

# Hack for zle bug 
# see https://github.com/robbyrussell/oh-my-zsh/pull/3610
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

##BindKey——实现可自定义的快捷键
# Correspondance touches-fonction
bindkey ''    beginning-of-line       # Home
bindkey "\e[1~" beginning-of-line
bindkey "\e[H"  beginning-of-line
bindkey ''    end-of-line             # End
bindkey "\e[4~" end-of-line
bindkey "\e[F"  end-of-line
bindkey ''    delete-char             # Del
bindkey '[3~' delete-char
bindkey '[2~' overwrite-mode          # Insert
bindkey '[5~' history-search-backward # PgUp
bindkey '[6~' history-search-forward  # PgDn

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
setopt AUTO_CD

# Prise en charge des touches [début], [fin] et autres
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

###########################################
# 3. Options de zsh (cf 'man zshoptions') #
###########################################

# Je ne veux JAMAIS de beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep
xset b off

# >| doit être utilisés pour pouvoir écraser un fichier déjà existant ;
# le fichier ne sera pas écrasé avec '>'
#unsetopt clobber
# Ctrl+D est équivalent à 'logout'
#unsetopt ignore_eof
# Affiche le code de sortie si différent de '0'
setopt print_exit_value
# Demande confirmation pour 'rm *'
unsetopt rm_star_silent
# Correction orthographique des commandes
# Désactivé car, contrairement à ce que dit le "man", il essaye de
# corriger les commandes avant de les hasher
#setopt correct
setopt nocorrectall
# Si on utilise des jokers dans une liste d'arguments, retire les jokers
# qui ne correspondent à rien au lieu de donner une erreur
setopt nullglob

# Schémas de complétion

# - Schéma A :
# 1ère tabulation : complète jusqu'au bout de la partie commune
# 2ème tabulation : propose une liste de choix
# 3ème tabulation : complète avec le 1er item de la liste
# 4ème tabulation : complète avec le 2ème item de la liste, etc...
# -> c'est le schéma de complétion par défaut de zsh.

# Schéma B :
# 1ère tabulation : propose une liste de choix et complète avec le 1er item
#                   de la liste
# 2ème tabulation : complète avec le 2ème item de la liste, etc...
# Si vous voulez ce schéma, décommentez la ligne suivante :
setopt menu_complete

# Schéma C :
# 1ère tabulation : complète jusqu'au bout de la partie commune et
#                   propose une liste de choix
# 2ème tabulation : complète avec le 1er item de la liste
# 3ème tabulation : complète avec le 2ème item de la liste, etc...
# Ce schéma est le meilleur à mon goût !
# Si vous voulez ce schéma, décommentez la ligne suivante :
#unsetopt list_ambiguous

# Options de complétion
# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effacé
setopt auto_remove_slash
# Ne fait pas de complétion sur les fichiers et répertoires cachés
unsetopt glob_dots

# Traite les liens symboliques comme il faut
setopt chase_links

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# complétion historique, il n'exécute pas la commande immédiatement
# mais il écrit la commande dans le prompt
setopt hist_verify
# Si la commande est invalide mais correspond au nom d'un sous-répertoire
# exécuter 'cd sous-répertoire'
#setopt auto_cd
# L'exécution de "cd" met le répertoire d'où l'on vient sur la pile
setopt auto_pushd
# Ignore les doublons dans la pile
setopt pushd_ignore_dups
# N'affiche pas la pile après un "pushd" ou "popd"
setopt pushd_silent
# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en tâche de fond sont nicé à '0'
unsetopt bg_nice
# N'envoie pas de "HUP" aux jobs qui tournent quand le shell se ferme
unsetopt hup


###############################################
# 4. Paramètres de l'historique des commandes #
###############################################

# The history is shared between all zshell
# And only the last occurrence of duplicates
setopt histignorealldups sharehistory

# Keep 5000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# Ajoute l'historique à la fin de l'ancien fichier
setopt append_history

# Chaque ligne est ajoutée dans l'historique à mesure qu'elle est tapée
setopt inc_append_history

# Ne stocke pas  une ligne dans l'historique si elle  est identique à la
# précédente
setopt hist_ignore_dups

# Supprime les  répétitions dans le fichier  d'historique, ne conservant
# que la dernière occurrence ajoutée
#setopt hist_ignore_all_dups

# Supprime les  répétitions dans l'historique lorsqu'il  est plein, mais
# pas avant
setopt hist_expire_dups_first

# N'enregistre  pas plus d'une fois  une même ligne, quelles  que soient
# les options fixées pour la session courante
setopt hist_save_no_dups

# La recherche dans  l'historique avec l'éditeur de commandes  de zsh ne
# montre  pas  une même  ligne  plus  d'une fois,  même  si  elle a  été
# enregistrée
setopt hist_find_no_dups


###########################################
# 5. Complétion des options des commandes #
###########################################

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


###########################################
# 6. Variables and preferences settings   #
###########################################

# Time zone
# use for the system:
#   sudo dpkg-reconfigure tzdata
#   or tzselect
#时区
export TZ="Europe/Paris"
#export TZ="Australia/Sydney"

# Vim is awesome ! :-)
export EDITOR="vim"


#语言和编码
export LANG=en_GB.utf-8
export LANGUAGE=en_GB.utf-8
#export LANG=en_US.utf-8
#export LANG="fr_FR.ISO8859-1"
#export LANG=""

export PYTHONPATH="/usr/bin/:/usr/lib:/usr/include"
export PYTHONPATH="usr/lib/python3:/usr/include/python3":$PYTHONPATH

export CHEATCOLORS=tru

# Support for bépo
export GTK_IM_MODULE=xim

###########################################
# 7. LAAS Specific Variables              #
###########################################

# Create files writable by group by default
umask 2

# GIT : Set this if you are using a different login on your laptop
export GIT_LAAS_USER=crobin

alias morse="morse -c" #color

# OpenRobots / robotpkg
export ROBOTPKG_BASE=${HOME}/LAAS/workspace/tools/openrobots
export PATH=${ROBOTPKG_BASE}/bin:${ROBOTPKG_BASE}/sbin:${PATH}
export LD_LIBRARY_PATH="${ROBOTPKG_BASE}/lib:${ROBOTPKG_BASE}/lib/openprs:${LD_LIBRARY_PATH}"
export PKG_CONFIG_PATH="${ROBOTPKG_BASE}/lib/pkgconfig:${PKG_CONFIG_PATH}"
export PYTHONPATH=${ROBOTPKG}/lib/python3.3/site-packages:${PYTHONPATH}

# ROS
#export ROS_OS_OVERRIDE=debian:squeeze
#LANG=en_US.utf-8
export ROS_PACKAGE_PATH=/home/crobin/LAAS/workspace/tools/openrobots/opt/ros/fuerte/
export ROS_MASTER_URI=http://localhost:11311
export PATH="$PATH:/home/crobin/LAAS/workspace/tools/openrobots/opt/ros/fuerte/bin"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/home/crobin/LAAS/workspace/tools/openrobots/opt/ros/fuerte/lib/pkgconfig"
export PYTHONPATH="$PYTHONPATH:/home/crobin/LAAS/workspace/tools/openrobots/opt/ros/fuerte/lib/python2.7/site-packages"
export TCLSERV_MODULE_PATH="${TCLSERV_MODULE_PATH}:/home/crobin/dev/lib/tclserv:${ROBOTPKG_BASE}/lib/tclserv"

# For demo genom3
#export PATH="$PATH:/home/crobin/LAAS/Courses/genom3_201310304/dummy-prefix/bin"
#export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/home/crobin/LAAS/Courses/genom3_201310304/dummy-prefix/lib/pkgconfig"
#export PYTHONPATH="$PYTHONPATH:/home/crobin/LAAS/Courses/genom3_201310304/dummy-prefix/lib/python2.7/site-packages"


# Morse
#export MORSE_BLENDER=/home/crobin/LAAS/workspace/tools/blender-2.64a-linux-glibc27-x86_64/blender
#export MORSE_ROOT=${HOME}/LAAS/workspace/tools/

# Environment for Jafar
export JAFAR_DIR=${HOME}/LAAS/workspace/jafar
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${JAFAR_DIR}/lib/x86_64-linux-gnu

# CVS Environment variables
#export CVSROOT=ssh://crobin@ncvs.laas.fr/cvs/action
export CVSROOT=:ext:crobin@ncvs.laas.fr:/cvs/action
export CVS_RSH=ssh
export CVSEDITOR=vim

# tkeclipse
export PATH="$PATH:/home/crobin/LAAS/workspace/tools/tkeclipse/bin/x86_64_linux"

# hyper
export HYPER_ROOT_ADDR="127.0.0.1:4242"
#export HYPER_ROOT_ADDR="localhost:4242"
export HYPER_ROOT="/home/crobin/dev/"
#export HYPER_ROOT=${ROBOTPKG_BASE}
export PYTHONPATH="/home/crobin/LAAS/workspace/tools/morse-action:${ROBOTPKG_BASE}/share/modules/python:${ROBOTPKG_BASE}/lib/python3.3/site-packages:$PYTHONPATH"

export BOOST_LIBRARYDIR="/usr/lib/x86_64-linux-gnu/:${BOOST_LIBRARY_DIR}"

export RUBYLIB="/home/crobin/LAAS/workspace/tools/analysis:$RUBYLIB"

# ACTION
export ACTION_HOME=/home/crobin/LAAS/workspace/tools
export MORSE_RESOURCE_PATH="${HOME}/LAAS/workspace/tools/morse-action/:${MORSE_RESOURCE_PATH}"
export PYTHONPATH="${HOME}/LAAS/workspace/tools/morse-action/:${PYTHONPATH}"
export PYTHONPATH="${HOME}/LAAS/workspace/tools/openrobots/share/modules/python/:${PYTHONPATH}"
#alias morse="env LD_LIBRARY_PATH=${ROBOTPKG_BASE}/lib morse"
export CMAKE_PREFIX_PATH=${ROBOTPKG_BASE}:${CMAKE_PREFIX_PATH}
export PYTHONPATH=${ACTION_HOME}/action-scripts:${PYTHONPATH}

# Simulation ACTION Mono AAV
export LUA_PATH="?;?.lua;$ROBOTPKG_BASE/lib/lua/rfsm/?.lua;$ROBOTPKG_BASE/share/lua/5.1/?.lua;/usr/share/lua/5.1/?.lua;/usr/lib/lua/5.1/?.lua"

######################### /LAAS ####################################

# Here at the end because order matters !
export PATH="${HOME}/dev/bin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/dev/lib:${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH="${HOME}/dev/lib/i386-linux-gnu:${LD_LIBRARY_PATH}"
export PKG_CONFIG_PATH="${HOME}/dev/lib/pkgconfig:${PKG_CONFIG_PATH}"
export INCLUDE="${HOME}/dev/include:${INCLUDE}"
export CMAKE_INCLUDE_PATH="${HOME}/dev/include:${INCLUDE}"
export CMAKE_INSTALL_PREFIX="${HOME}/dev/"
#export PYTHONPATH="${PYTHONPATH}:/usr/lib/python3/dist-packages:/usr/lib/python3.3"
#export PYTHONPATH="${PYTHONPATH}:/usr/local/bin/:/usr/local/lib:/usr/local/include:/usr/local/lib/python3/dist-packages/"
export PYTHONPATH="${HOME}/dev/lib/python2.7/dist-packages:${HOME}/dev/lib/python3/dist-packages:$PYTHONPATH"

# GLPK
export PYTHONPATH="${HOME}/dev/lib/python2.7/site-packages:${HOME}/dev/lib/python3/site-packages:$PYTHONPATH"

#export ROBOT=minnie

# Prolog : eclipse
export PATH=$PATH:/home/crobin/dev/src/eclipse_prolog/bin/x86_64_linux

export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib"