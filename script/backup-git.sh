docker run -itd \
    istepanov/backup-to-git \
    -e GIT_NAME:'ii6u99' \    #git用户名
    -e GIT_EMAIL:'ii6uu99@163.com' \   #git用户电子邮件
    -e GIT_URL:https://ii6uu99:hzm373566162@github.com/ii6uu99/.dotfiles.git \ #git远程路径
    -e CRON_SCHEDULE='*/5 * * * *' \ #每五分钟备份一次
    -v $HOME/.dotfiles:/target:ro \ ##将目标本地文件夹挂载到容器的数据文件，将会备份到git
    /entrypoint.sh

