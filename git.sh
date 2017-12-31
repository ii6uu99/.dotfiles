#!/bin/sh
#来源 https://github.com/neil-smithline-shellscripts/auto-git-push

PATH="~/bin:/sbin:/bin:/var/sbin:/var/bin:/usr/local/bin:$PATH"

cd "$1"
git add -A .
git commit -q -m 'aa'
git push -q

#通过+master强行更新
#git push -u origin +master
