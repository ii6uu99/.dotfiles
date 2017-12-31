function has_push_access() {
	local http_status=$(curl -s -i -u benburwell:$GITHUB_TOKEN https://api.github.com/repos/$1/$2/collaborators | grep -i status)
	if [[ $(echo "$http_status" | grep -i forbidden) ]]; then
		return 1
	fi
	return 0
}

function ghclone() {
	if [[ $# -lt 1 ]]; then
		echo "Usage: ghclone <username/repo>"
		return 1
	fi

	local username=$(echo "$1" | cut -d'/' -f1)
	local repo=$(echo "$1" | cut -d'/' -f2)
	local target_dir="$PROJECTS/src/github.com/$username"
	mkdir -p "$target_dir"

	if (has_push_access $username $repo); then
		url="git@github.com:$username/$repo.git"
	else
		url="https://github.com/$username/$repo.git"
	fi

	echo "Cloning $url into $target_dir..."
	git clone "$url" "$target_dir/$repo"
	cd "$target_dir/$repo"
}
