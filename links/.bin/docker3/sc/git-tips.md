# Remember passwords for 1hr.
git config --global credential.helper 'cache --timeout=3600'
https://help.github.com/articles/caching-your-github-password-in-git/

# Delete branch local
git branch -d branch_name

# Delete branch remote
git push origin --delete <branch_name>

# Sync Deletes on other machines
git fetch --all --prune

# Branching and Merging
https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging
