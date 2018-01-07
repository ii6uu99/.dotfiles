#sudo vim /etc/apt/sources.list

sudo tee /etc/apt/sources.list <<-'EOF'
deb [by-hash=force] http://mirrors.ustc.edu.cn/deepin unstable main contrib non-free
#deb-src http://mirrors.ustc.edu.cn/deepin unstable main contrib non-free
EOF
sudo apt-get update
