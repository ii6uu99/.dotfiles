# Start ubuntu container:
# -i is interactive, -rm deletes volume after close
docker run -t -i ubuntu /bin/bash

# Installl Python3:
#update
apt-get update
apt-get -y upgrade

apt-get install software-properties-common
add-apt-repository ppa:deadsnakes/ppa
apt-get update
apt-get install python3.6

pathToPython3=$(which python3)
echo $pathToPython3

# Install pip:
apt-get install python-pip

# Install virtualenv
pip install virtualenv

pip install --upgrade pip

mkdir .virtualenvs
cd .virtualenvs

cd ~
apt-get –y install git

# leave container
exit

# Make docker image
mostRecentContainerID=$(docker ps -l -q)
docker commit $mostRecentContainerID explorer:version1

# then run it:
docker run -t -i explorer:version1
# start virtualenv
source /.virtualenvs/explorer_virtualenv/bin/activate
