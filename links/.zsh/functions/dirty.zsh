function dirty() {
	base=~/code/src/github.com/virtyx-technologies
	yellow='\033[0;33m'
	green='\033[0;32m'
	nc='\033[0m'
	for repo in $(ls "$base"); do
		p="$base/$repo"
		is_dirty=$(git --git-dir="$p/.git" --work-tree="$p" diff --shortstat 2> /dev/null | tail -n1)
		branch=$(git --git-dir="$p/.git" --work-tree="$p" rev-parse --abbrev-ref HEAD 2> /dev/null)
		if [[ $branch != "master" && $branch != "HEAD" ]]; then
			pr=$(curl --silent "https://benburwell:$GITHUB_TOKEN@api.github.com/repos/virtyx-technologies/$repo/pulls?state=open&head=virtyx-technologies:$branch&base=master" | jq --raw-output --monochrome-output '.[0]._links.html.href')
			pr_link=$([[ $pr != "null" ]] && echo "($pr)")
			if [[ $is_dirty != "" ]]; then
				echo "$repo: ${yellow}$branch${nc} $pr_link"
			else
				echo "$repo: ${green}$branch${nc} $pr_link"
			fi
		else
			if [[ $is_dirty ]]; then
				echo "$repo: ${yellow}$branch${nc} $pr_link"
			fi
		fi
	done
}
