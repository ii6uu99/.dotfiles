#esecute shell script on remote host using ssh
# ------ ssh site : centos@52.206.52.245:22

# ------ command ------

#!/bin/bash -ex
#docker service update --mount-add type=bind,src=/tmp/mongobackup,dst=/tmp/mongobackup mongoreplica
docker exec $(docker ps -f name=mongoreplica -q) bash -c 'rm -Rf /tmp/mongobackup/* && mongodump -v -h mongoreplica:27017 --out=/tmp/mongobackup/mongodump --gzip && chmod -R a+rw /tmp/mongobackup/*'
tar --remove-files -cvzf /tmp/mongobackup/backup-`date +"%Y%m%d.%H%M"`.mongodump.tar.gz /tmp/mongobackup/mongodump/*
ls -lh /tmp/mongobackup
#sshpass -p mongobackup1 sftp mongobackup@10.16.17.10 <<< $'put /tmp/mongobackup/backup-*.mongodump.tar.gz'
#rm /tmp/mongobackup/backup-*.mongodump.tar.gz


# ------ execute shell ------
scp -i /home/jenkins/.ssh/dephinitive.pem -o StrictHostKeyChecking=no centos@52.206.52.245:/tmp/mongobackup/backup*.tar.gz .
ssh -i /home/jenkins/.ssh/dephinitive.pem -o StrictHostKeyChecking=no centos@52.206.52.245 'rm -f /tmp/mongobackup/backup*.tar.gz'