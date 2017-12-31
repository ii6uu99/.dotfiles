#!/bin/bash

set -e

GIT_NAME=ii6uu99
GIT_EMAIL=ii6uu99@163.com
GIT_URL=https://ii6uu99:hzm373566162@github.com/ii6uu99/.dotfiles.git
GIT_BRANCH=master
GIT_COMMIT_MESSAGE='.'
TARGET_FOLDER=/target

export GIT_DIR="/var/git"
export GIT_WORK_TREE="$TARGET_FOLDER"

echo "Job started: $(date)"
echo "$GIT_WORK_TREE"

if [ ! -d "$GIT_DIR" ]; then
    mkdir -p "$GIT_DIR"
    git init
    git config user.name "$GIT_NAME"
    git config user.email "$GIT_EMAIL"
    git remote add origin "$GIT_URL"

    mkdir -p "$GIT_DIR/info"
    echo '' > "$GIT_DIR/info/exclude"
    while IFS=';' read -ra IGNORE_PATTERNS; do
        for i in "${IGNORE_PATTERNS[@]}"; do
            echo "$i" >> "$GIT_DIR/info/exclude"
        done
    done <<< "$GIT_IGNORE"

    git fetch --all
    git symbolic-ref HEAD refs/remotes/origin/$GIT_BRANCH
    git reset
    git checkout -b $GIT_BRANCH

    # to get rid of ignored files that are already commited to the repo,
    # remove all files for index (but not from working directory!),
    # then re-add everything back to index
    git rm -r --cached . > /dev/null || true
fi

git add -A

git commit -m "$GIT_COMMIT_MESSAGE"
git push origin $GIT_BRANCH

echo "Job finished: $(date)"
