#https://github.com/qishibo/goagent
#google host update shell for Mac and Linux
#
#原理: 从github上下载google host，然后写到/etc/hosts中，如果不相信脚本，可以 自己实现这个功能
#
#下载的脚本默认是没有执行权限的，所以先 sudo chmod +x forMacAndLinux.sh

curl 'https://raw.githubusercontent.com/racaljk/hosts/master/hosts' -o $HOME/fetchedhosts

#udo mv $HOME/fetchedhosts /etc/hosts
sudo mv $HOME/fetchedhosts /etc/hosts

rm -f $HOME/fetchedhosts

echo "finish......"

sleep 1

