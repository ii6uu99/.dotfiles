# GitHub Request Pull
#
# Assuming the current git repo's `origin` is on GitHub, open the pull request
# editor for the current branch.
function rp() {
	local upstream=$(git config --get remote.origin.url | cut -d':' -f2 | sed 's/\.git$//')
	local branch=$(git rev-parse --abbrev-ref HEAD)
	local url=https://github.com/$upstream/compare/$branch?expand=1
	open -a "Google Chrome" "$url"
}
