#自动添加cron命令，实现自动运行git脚本

BACKUP_DIR=$HOME/.dotfiles  #要备份的路径
GIT_DIR=$BACKUP_DIR/git.sh #git自动push脚本路径



#1.给脚本提高权限
sudo chmod 777 $GIT_DIR

#2.安装crontab
sudo apt-get install cron crontab

#3.创建cron策略
crontab -l | { cat; echo "*/1 * * * * $HOME/.dotfiles/git.sh $HOME/.dotfiles"; } | crontab -

#4.查看服务路径：
CRON_DIR=`which service`

#5 重新加载cron配置文件
sudo $CRON_DIR cron reload


#6 重新启动cron服务
sudo $CRON_DIR cron restart

#7.查看cron的运行状态
sudo $CRON_DIR cron status

