## make sure your EC2 instance has the correct security group and is open on the connecting port

# ------ Typical ~/.ssh/config ------
## Personal
# Host jahdocker #my docker dev
#   Hostname 34.195.153.103
#   User ubuntu
#   IdentityFile ~/.ssh/personal/jah-docker.pem


# ------ Install Docker Non-Sudo ------

## login
ssh jahdocker

## Install Docker
sudo apt update
sudo apt install apt-transport-https ca-certificates
sudo apt-key adv \
   --keyserver hkp://ha.pool.sks-keyservers.net:80 \
   --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# uname -r
# lsb_release -rs
# add docker-engine to ppa sources
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt-get install docker-engine
sudo service docker start

# Uncomment to test docker
# sudo docker run hello-world

## make docker not require "sudo"
sudo groupadd docker
sudo gpasswd -a $(whoami) docker
sudo service docker restart

# log out to get ready for next ssh
exit

# ------  ------


# ------ Set Up Docker and Jenkins Master ------

# log in
ssh jahdocker

# install aws cli
sudo apt install awscli

# docker create data volume
docker volume create --name jenkins_home

# as a test to check the contents or modify jenkins_home
# PROOVE THIS CODE!!!
aws s3 cp s3://dephinitive-backups/jenkins/FULL----- /tmp/backup/
tar -xzf /var/lib/docker/volumes/dataVolumeTest/_data/ /tmp/backup/FULL----

# start up jenkins as master with a
docker volume create --name jenkins_home
docker run -p 8080:8080 --name jenkins-master -p 50000:50000 -d -v jenkins_home:/var/jenkins_home jenkins
docker cp jenkins-master:/var/jenkins_home/secrets/initialAdminPassword /tmp/initialAdminPassword
cat /tmp/initialAdminPassword

# ------  ------