#自动生成github的ssh key，并复制到粘贴板

#####设置ssh
#cd $HOME
#ssh-keygen -C "$(whoami)@$(hostname)-$(date -I)"

#生成新的ssh key
ssh-keygen -t rsa -C "ii6uu99@163.com"

#将新生成的key添加到ssh-agent中
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

#linux复制到粘贴板
sudo apt-get install xclip
xclip -sel clip < ~/.ssh/id_rsa.pub
