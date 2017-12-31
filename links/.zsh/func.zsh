# 快速建立資料夾並且切換到該資料夾下
md () { mkdir -p "$1" && cd "$1"; }

# 在命令列顯示目前所在分支
function git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo "("${ref#refs/heads/}") ";
}

# 在命令列顯示最後的提交時間
function git_since_last_commit {
    now=`date +%s`;
    last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
    seconds_since_last_commit=$((now-last_commit));
    minutes_since_last_commit=$((seconds_since_last_commit/60));
    hours_since_last_commit=$((minutes_since_last_commit/60));
    minutes_since_last_commit=$((minutes_since_last_commit%60));

    echo "${hours_since_last_commit}h${minutes_since_last_commit}m ";
}

#FUNCTIONS
ioup_clear() {
	for file in `ioup -l | awk '{print $1}'`; do
		ioup -r $file
	done
}

ix() {
	cat "$1" | curl -F 'f:1=<-' -F 'read:1=2' ix.io 
}

getip() {
	w3m -no-cookie -dump "https://duckduckgo.com/?q=what+is+my+ip+address&t=ffab&ia=answer" | awk '/address is/ {print $5}' | head -1
}

mtp-mount() {
	gvfs-mount -li | awk -F= '{if(index($2,"mtp") == 1)system("gvfs-mount "$2)}'
}

separator() {
	for ((x = 0; x < $(tput cols); x++)); do
		printf %s "$(tput setaf 0)█$(tput sgr0)"
	done
}

