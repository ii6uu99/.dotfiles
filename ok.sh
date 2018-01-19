#!/bin/bash
#Could not stat device htop


sudo tee /etc/apt/sources.list <<-'EOF'
deb [by-hash=force] http://mirrors.aliyun.com/deepin unstable main contrib non-free 
deb-src http://mirrors.aliyun.com/deepin unstable main contrib non-free
EOF

#更新系统和升级系统
sudo apt-get update -y
sudo apt-get upgrade -y

#安装txt中的软件
#sudo apt-get install -y $(grep -vE "^\s*#" $HOME/dotfiles/install-apt  | tr "\n" " ")

#安装dotfile必备的软件
#xclip复制工具
sudo apt-get install -y --no-install-recommends curl wget tmux vim  zsh git xclip 




###### 获取所需的主要包
sudo apt-get install -y \
zsh vim vim-gtk git tig colordiff \
texlive-full rubber tmux \
make make-doc cmake-curses-gui \
awesome awesome-extra slim conky \
i3lock libnotify-bin xfonts-terminus ttf-dejavu xcompmgr alsa-utils \
pavucontrol gnome-bluetooth pulseaudio numlockx rxvt-unicode-256color xsel\
xbacklight cmus \
uzbl chromium-browser \
python-fontforge filezilla calibre \
system-config-printer-common \
mutt-patched urlview abook \
offlineimap msmtp \
gparted unetbootin \
calibre synaptic p7zip-rar \
python-numpy python3-numpy \
python-all-dev python3-all-dev \
python-doc python3-doc \
python-matplotlib python3-matplotlib \
python-gdal python3-gdal \
ipython ipython3 python-ipdb python3-ipdb \
ipython-doc \
gdal-bin \
inkscape \
vlc

#pip install -r requirements.txt

#安装oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

# Get oh-my-zsh
if [ ! -e ~/.vim/oh-my-zsh ]
then 
    git clone https://github.com/robbyrussell/oh-my-zsh ~/.zsh/oh-my-zsh
fi


#############################################
##链接
#############################################


#删除文件
cd $HOME
rm -f .bashrc
rm -f .zshrc
rm -f .tmux
rm -f .vimrc


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

#######################################################
#cat >~/.zshrc<<END
#source ~/.alias
#END


git submodule update --init
git submodule foreach git pull origin master

 
#设置zsh为默认shell
#sudo chsh -s /bin/zsh `whoami`
chsh -s /bin/zsh $(whoami)
#chsh -s /bin/bash $(whoami)



#vim创建
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/jefflund/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginUpdate +qa

vim +GoInstallBinaries +qa

#vim升级插件
vim +BundleInstall +qall

## 安装脚本docker and docker-compose
sudo apt-get install curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/reggiezhang/docker-install/master/install.sh)"

#添加脚本命令到.bashrc
echo "export PATH=/home/cqh:$PATH" >> /etc/profile

#添加自定义的命令到环境变量
echo "export PATH=$HOME/.dotfiles/links/.bin:$PATH" >> $HOME/.bashrc
#linux 文件批量赋予权限
#chmod -R 权限值 目录或文件
chmod -R 750 $HOME/.dotfiles/links/.bin
source $HOME/.bashrc

#deepin安装蓝灯
#https://github.com/getlantern/lantern
sudo apt-get install libappindicator3-1

#安装docker
bash $HOME/.dotfiles/script/aliyun.sh

#定时备份git，cron启动
bash /home/ming/.dotfiles/script/auto-git.sh




