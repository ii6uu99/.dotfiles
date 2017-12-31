prompt_segment() {
	local fg
	[[ -n $1 ]] && fg="%F{$1}" || fg="%f"
	echo -n "%{$fg%}"
	[[ -n $2 ]] && echo -n "$2 "
}

# End the prompt, closing any open segments
prompt_end() {
	echo -n "%{%f%}"
}

# Git: branch/detached head, dirty status
prompt_git() {

  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  }
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(git status --porcelain 2> /dev/null | wc -l)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ $dirty -ne 0 ]]; then
      prompt_segment yellow
    else
      prompt_segment green
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '+'
    zstyle ':vcs_info:git:*' unstagedstr '*'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\//}${vcs_info_msg_0_%% }${mode}"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue '%~'
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
	[[ $RETVAL -ne 0 ]] && prompt_segment red "[$RETVAL]"
	[[ $UID -eq 0 ]] && prompt_segment green "[su]"
	[[ $(jobs -l | wc -l) -gt 0 ]] && prompt_segment yellow "[bg]"
}

prompt_user_host() {
	prompt_segment magenta "%n@%m"
}

prompt_ssh() {
	[[ $SSH_CONNECTION ]] && prompt_segment red "(SSH)"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_user_host
  prompt_ssh
  prompt_dir
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt)
%F{8}$%F{reset} '

