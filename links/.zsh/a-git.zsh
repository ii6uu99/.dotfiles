alias a-g="vim /.dotfiles/links/.zsh/a-git.zsh"   #vim编辑本文件

alias gd="git diff"
alias gl="git log"
alias gs="git status"

alias gcm="git checkout master"
alias gcd="git checkout develop"

alias ga="git add"
alias gaa="git add --all"

alias gc="git commit -m "
alias gp="git push"
alias gpom="git push origin master;"

alias nah="git reset --hard && git clean -df"

alias ga="git add;"
alias gaa="git add --all;"

alias diff="echo q to quit; git diff --cached;"
alias stashchanges="git stash save --keep-index;"
alias stash="git stash save --keep-index; echo -git stash drop- to remove stash;"
alias chrem="git remote set-url origin"
alias abortmerge="git reset --hard HEAD"
alias bashprofile="cd; vi .bash_profile;"
alias rem="git remote -v;"
com(){
git commit -m "$1";
}



alias git-clean='git branch --merged master | ' \
                'grep -v "\* master" | ' \
                'xargs -n 1 git branch -d'
