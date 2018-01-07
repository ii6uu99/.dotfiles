#sudo vim /etc/apt/sources.list

sudo tee /etc/apt/sources.list <<-'EOF'
deb http://mirrors.aliyun.com/ubuntu raring main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu raring-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu raring-updates main restricted universe multiverse
# deb http://mirrors.aliyun.com/ubuntu raring-proposed main restricted universe multiverse
# deb http://mirrors.aliyun.com/ubuntu raring-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu raring main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu raring-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu raring-updates main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu raring-proposed main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu raring-backports main restricted universe multiverse

EOF
