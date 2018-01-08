#解决request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
#docker加速

sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  #"registry-mirrors": ["https://r2t47usc.mirror.aliyuncs.com"]
  "registry-mirrors":["https://docker.mirrors.ustc.edu.cn"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

