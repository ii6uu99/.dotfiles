[[ "${OSTYPE}" =~ "darwin" ]] && alias os_readlink='readlink'
[[ "${OSTYPE}" =~ "linux" ]] && alias os_readlink='readlink -f'

DOTFILES_PATH=$(dirname $(os_readlink ~/.zshrc))


. $DOTFILES_PATH/common.sh

PATH=/sbin:/usr/sbin:/usr/local/sbin:$PATH
PATH=/usr/local/bin:$PATH
PATH=$PATH:/opt/bin
PATH=$PATH:$HOME/bin
PATH=$PATH:$DOTFILES_PATH/bin

PROMPT_PREFIXES=()
PROMPT_SUFFIXES=()

precmd () {
    ## Set prompt, window title, and tab title
    local _prefix=""
    local _suffix=""
    [ -n "${PROMPT_PREFIXES}" ] && _prefix="%{$fg[green]%}[${PROMPT_PREFIXES}]%{$reset_color%} "
    [ -n "${PROMPT_SUFFIXES}" ] && _suffix=" %{$fg[green]%}[${PROMPT_SUFFIXES}]%{$reset_color%}"

    export HOST_SHORT=${${HOST/.local/}%.*.*}
    export PROMPT="${_prefix}%{$fg[blue]%}${HOST_SHORT}:%~%{$reset_color%}${_suffix}%# "
    print -Pn "\e]2;%n@${HOST%.*.*}:%~\a"  ## window
    print -Pn "\e]1;%n@${HOST%.*.*}:%~\a"  ## tab
}

prompt_prefix_add () {
    PROMPT_PREFIXES+=("$1")
}
prompt_prefix_remove () {
    PROMPT_PREFIXES=(${(@)PROMPT_PREFIXES:#$1})
}

prompt_suffix_add () {
    PROMPT_SUFFIXES+=("$1")
}
prompt_suffix_remove () {
    PROMPT_SUFFIXES=(${(@)PROMPT_PREFIXES:#$1})
}

path_prepend () {
    path=("$1" $path)
}
path_append () {
    path+=("$1")
}
path_remove () {
    path=(${(@)path:#$1})
}

source_if_exists () {
    [[ -f "$1" ]] && source "$1"
}

randpass () {
    [[ "$2" == "0" ]] && CHAR="[:alnum:]" || CHAR="[:graph:]"
    cat /dev/urandom | tr -cd "$CHAR" | head -c ${1:-32}
    echo
}

nowrap () {
    cut -c -$(tput cols)
}


_detect_platform


[ -d ~/.zsh/completion ] &&
    fpath=(~/.zsh/completion $fpath)

autoload -U compinit && compinit
autoload -U colors && colors

setopt AUTO_CD
setopt AUTO_PUSHD
setopt GLOB_COMPLETE
setopt PUSHD_MINUS
setopt PUSHD_TO_HOME

#setopt VI
setopt EMACS
export EDITOR="vim"

setopt NUMERIC_GLOB_SORT
setopt RC_EXPAND_PARAM

export CLICOLOR="yes"
export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
export LS_OPTIONS='--color=auto'

if [ ! -f /usr/bin/dircolors ]; then
    export LS_COLORS="di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;45:tw=:ow=:"
    alias ls='ls -G'
else
    eval $(dircolors)
    export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
    alias ls='ls --color'
fi

alias ez='vim ~/.zshrc'
alias ll='ls -l'
alias llt='ls -ltr'

alias tmux='tmux -2'
alias tx='tmux -2'
alias txl='tmux list-sessions'
alias txa='tmux attach-session -t'
alias txn='tmux new-session -s'

alias sl='slcli'

[ -f ~/.bcrc ] \
    && alias bc='bc -l ~/.bcrc' \
    || alias bc='bc -l'

(which jq >/dev/null 2>&1) \
    && alias json='jq .' \
    || alias json='python -m json.tool'


if [[ "${PLATFORM}" == "linux" ]]; then
    CKEYS_FILE=/usr/share/X11/locale/en_US.UTF-8/Compose
    [[ -f ${CKEYS_FILE} ]] && alias ckeys="${EDITOR} ${CKEYS_FILE}"
fi


bindkey '^[[1~' beginning-of-line      # Home
bindkey '^[[H' beginning-of-line       # Home
bindkey '^[OH' beginning-of-line       # Home
bindkey '^[[4~' end-of-line            # End
bindkey '^[[F'  end-of-line            # End
bindkey '^[OF' end-of-line             # End

bindkey '^[[5~' beginning-of-history   # PgUp
bindkey '^[[6~' end-of-history         # PgDown
bindkey '^[[A' up-line-or-search       # Up
bindkey '^[[B' down-line-or-search     # Down

bindkey '^[w' kill-region              # Esc-w (delete entire line)
bindkey '^[[3~' delete-char            # Del

imv() {
    local src dst
    for src; do
        [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
        dst=$src
        vared -p 'New file name: ' dst
        [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
    done
}


HISTFILE=~/.history
SAVEHIST=500000
HISTSIZE=100000

setopt INTERACTIVECOMMENTS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

setopt EXTENDED_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS


[[ -d "/sw/bin" ]] && \
    export FINK_HOME=/sw && \
    path_append /sw/bin

[[ -s $HOME/.pyenv/bin/pyenv ]] && \
    export PYENV_ROOT=$HOME/.pyenv && \
    export PATH="$PYENV_ROOT/bin:$PATH" && \
    eval "$(pyenv init -)"

[[ -d "/opt/scala/bin" ]] && \
    export SCALA_HOME=/opt/scala && \
    path_append $SCALA_HOME/bin

[[ -d "$HOME/app/android" ]] && \
    export ANDROID_HOME=$HOME/app/android/sdk && \
    path_append $ANDROID_HOME/platform-tools:$ANDROID_HOME/tools


source_if_exists ~/.env-work/.zshrc
source_if_exists ~/.zsh/ssh-util.sh
source_if_exists ~/.zsh/git-prompt.sh
source_if_exists ~/.zsh/git-editor.sh
source_if_exists ~/.zsh/git-ignore.sh
source_if_exists ~/.zsh/chef.sh
source_if_exists ~/.zsh/packer.sh
source_if_exists ~/.zsh/swag.sh
source_if_exists ~/.zsh/sl-utils.sh
source_if_exists ~/.zsh/cordova-util.sh
source_if_exists ~/.slrc


[[ -d "$HOME/.rbenv" ]] && eval "$(rbenv init -)" && \
    export ENV_USE_RBENV=true

[ ! "$ENV_USE_RBENV" ] && [ ! "$ENV_NO_RVM" ] && \
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && \
    path_append $HOME/.rvm/bin && \
    source "$HOME/.rvm/scripts/rvm"  # Load RVM into environment as a function
