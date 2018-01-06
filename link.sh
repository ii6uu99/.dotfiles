#路径变量
dotfiles_dir=$HOME/.dotfiles

cd $HOME/.dotfiles/links
# 首先创建必须的文件夹
for d in $(find . ! -path . -type d); do
	mkdir -p $HOME/${d}
done
# 创建文件的链接
for f in $(find . -type f); do
	src="$HOME/.dotfiles/links/$f"
	dst="$HOME/$f"
	if [ ! -f $dst ]; then
		echo "===> link $dst"
		ln -sf $src $dst
	else
		echo "--->$dst已存在,跳过"
	fi
done

/usr/local/bin
