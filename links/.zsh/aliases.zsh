#重启zshrc
alias ok='source ~/.zshrc && source ~/.bashrc && echo "ok"'


# 快速導覽
alias ..="cd .."
alias ...="cd ../.."

# 列出目錄清單
alias la="ls -al"                          # 清單列表所有隱藏不隱藏的資料夾和檔案
alias l="ls -lp"                           # 清單列表不隱藏的資料夾和檔案
alias ls="ls -lp"
alias ld='ls -l ${colorflag} | grep "^d"'  # 清單列表只列出資料夾

# 捷徑
alias c="clear"
alias s="subl ."
alias o="open"
alias oo="open ."

# Octopress
alias rp="rake preview"
alias rg="rake generate"
alias rd="rake deploy"
alias rgd="rake generate; rake deploy"

# 任意門……
alias blog="cd ~/Code/Project/octopress/chinghanho"
alias dotfiles="cd ~/.dotfiles"
alias prj="cd ~/Code/Project"
alias pra="cd ~/Code/Practice"
alias sdx="cd ~/Code/Sandbox"

alias coffitivity="open -a /Applications/MPlayerX.app ~/Dropbox/Music/Coffitivity.mp3 --args -file -volume 50 -StartByFullScreen NO"

# virtualenvwrapper
alias v="workon"
alias vls="lsvirtualenv"
alias vcp="cpvirtualenv"
alias vquit="deactivate"
alias vmk="mkvirtualenv"
alias vrm="rmvirtualenv"
alias vswitch="workon"

# 有用的東西
alias ip="curl ipecho.net/plain; echo"

# 網速測試
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"


alias emacs="emacs -nw"
alias ne="emacs -nw"
alias sne="sudo emacs -nw"
alias m='make debug; make clean'
alias clean="find -name '#*#' -delete -o -name '*~' -delete"
alias sclean="sudo find -name '#*#' -delete -o -name '*~' -delete"
alias gRn="grep -Rn"
alias gdb="gdb --silent"
alias g+="g++ -W -Wall -Werror -Wextra *.cpp"
alias c+="clang++ -W -Wall -Werror -Wextra *.cpp"
alias g="gcc -W -Wall -Werror -Wextra *.c"

alias indent_c='find . -iname \*.c -or -iname \*.h -exec emacs -nw -q {} --eval "(progn (mark-whole-buffer) (indent-region (point-min) (point-max) nil) (save-buffer))" --kill \;'
alias indent_cpp='find . -iname \*.cpp -or -iname \*.hpp -exec emacs -nw -q {} --eval "(progn (mark-whole-buffer) (indent-region (point-min) (point-max) nil) (save-buffer))" --kill \;'

count_char()
{
    echo -n "$*" | wc -c
}

highlight()
{
    perl -pe "s/$1/\e[1;31;43m$&\e[0m/g"
}












# git
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gbs="git-branches"
alias gc="git commit"
alias gcb="git checkout -b"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gd="git diff"
alias gds="git diff --staged"
alias gf="git fetch"
alias gl="git pull"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%aN>%Creset' --abbrev-commit"
alias glr="git pull --rebase"
alias glsr="git ls-remote"
alias gm="git merge"
alias gp="git push"
alias gr="git remote"
alias gs="git status"
alias gsl="git stash list"
alias gsp="git stash pop"
alias gss="git stash save"
alias gt="git tag"

# golang
alias gob="go build"
alias gof="go fmt"
alias gog="go get"
alias goi="go install"

# heroku
alias h="heroku"
alias hlt="heroku logs --tail"
alias hpg="heroku pg:psql"
alias hps="heroku ps"
alias hpss="heroku ps:scale"

# party parrot
alias celebrate="terminal-parrot -delay 50 -loops 3"
alias parrot="terminal-parrot"

# docker-compose
alias dc="docker-compose"
alias dcd="docker-compose down"
alias dcl="docker-compose pull"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"

# docker
alias d="docker"
alias dim="docker images"
alias dps="docker ps"
alias dpsa="docker ps -a"

# make
alias m="make"

alias efzf="e \$(fzf --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {} || cat {}) 2> /dev/null | head -500')"

alias a="git add -A"
c() { git commit -m "$*"}
alias h="git push"
alias prod="git push prod"
alias stage="git push staging"
alias s="git status"
alias v='vim'
alias t='vim ~/Todo'
alias ud='sudo apt-get update'
alias ug='sudo apt-get dist-upgrade'
alias fug='sudo aptitude full-upgrade'
alias bu='bundle update'
alias tmux='tmux -2'
alias m='mux'
alias gl="git pull --rebase"
alias suspensions="tail -10000 /var/log/pm-suspend.log | grep -B1 'Finished'"
alias ta="tar -czvf"
alias uta="tar -zxvf"

################
# 1. Les alias #
################

# Gestion du 'ls' : couleur & ne touche pas aux accents
alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'

# Raccourcis pour 'ls'
alias ll='ls -alhF'
alias la='ls -Ah'
alias lr='ls -Rh'
alias l='ls -CFh'
alias llra="ll -R"

# Demande confirmation avant d'écraser un fichier
# et prise en compte de répertoires (récursif)
alias cp='cp --interactive -r'
alias mv='mv --interactive'
alias rm='rm --interactive -r'

# Quelques alias pratiques
alias c='clear'
alias less='less --quiet'
alias s='cd ..'
alias df='df --human-readable'
alias du='du --human-readable'
alias md='mkdir'
alias rd='rmdir'
alias upgrade='sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean'
alias pd="popd"
alias nd="pushd"

alias srczsh="source ~/.zshrc"

alias vim="vim -p"
alias view="view -p"
alias svim="sudo vim"
alias vd="vimdiff"
alias vimcf="vim ~/.vim/vimrc"

alias gdt="git difftool"

# git alias are handle by oh-my-zsh git plugin

# alias for todo.txt
alias td="${HOME}/dev/scripts/todo.txt-cli/todo.sh -ant -d ${HOME}/.todo/todo.cfg"
alias d="td"

# alias for Quick Calculator qc
# a shell script using python to compute math in command line
alias qc="${HOME}/dev/scripts/qc.sh"

# alias for bd
alias bd=". bd -s"

alias swipl='export LANG=""; swipl'

# alias for acICP (LAAS / ACTION project"
alias acICP='export LC_CTYPE="fr_FR.utf8"; echo "export LC_CTYPE=$LC_CTYPE" ; acICP'

# alias rsync
alias dotsync="rsync -av \
    ~/.zsh --exclude oh-my-zsh/ \
    ~/.gitconfig \
    ~/.todo \
    ~/.mutt --exclude cache/ \
    ~/.urlview \
    ~/.cmus --exclude cache \
    ~/.lesskey \
    ~/.dotfiles/"

alias update_dotfiles="rsync -uv \
    ~/.dotfiles/.* --exclude .git/ ~/"

# Mutt alias
alias ml="mutt -F ~/.mutt/muttrc_laas"
alias mg="mutt -F ~/.mutt/muttrc_gmail"
alias mm="mutt -F ~/.mutt/muttrc_me"
#alias m='mutt -y'

# awesome
alias awesomecf="vim ~/.config/awesome/rc.lua"

# programmation
alias p3="python3"
alias p2="python2.7"

# libreoffice
alias lo="libreoffice"

# Lock screen
alias afk="gnome-screensaver-command -l"

# Copy to clipboard
alias copy="xclip -selection clipboard"

# Shortcut for capslock toggle script
alias cl="capslock"

# Set keyboard to Colemak
cm() {
  setxkbmap us -variant colemak
  xset r 66
  echo "Keyboard set to Colemak"
}

# Set keyboard to QWERTY
qw() {
  setxkbmap us
  xset -r 66
  echo "Keyboard set to QWERTY"
}


