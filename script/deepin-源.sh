#sudo vim /etc/apt/sources.list

sudo tee /etc/apt/sources.list <<-'EOF'
#中科大源
deb [by-hash=force] http://mirrors.ustc.edu.cn/deepin unstable main contrib non-free
#deb-src http://mirrors.ustc.edu.cn/deepin unstable main contrib non-free
EOF

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410

sudo apt-get update


#deepin更新阿里云源
echo -e "deb [by-hash=force] http://mirrors.aliyun.com/deepin unstable main contrib non-free \ndeb-src http://mirrors.aliyun.com/deepin unstable main contrib non-free" | sudo tee /etc/apt/sources.list
