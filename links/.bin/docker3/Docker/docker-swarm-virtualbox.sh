#############################################################
Docker swarm setup using the Virtualbox with Docker machine## 
#############################################################
docker-machine  -v
docker ps -a
docker-machine create -d virtualbox local
eval "$(docker-machine env local)"
docker run swarm create
docker-machine create -d virtualbox --swarm --swarm-master --swarm-discovery token://<token_ID>
swarm-manager
docker-machine create -d virtualbox --swarm  --swarm-discovery token://<token_ID> swarm-node0
eval "$(docker-machine env local)"
docker info
docker-machine create -d virtualbox --swarm  --swarm-discovery token://<token_ID> swarm-node1
docker-machine create -d virtualbox --swarm  --swarm-discovery token://<token_ID> swarm-node2
#Below command to connect to the different Nodes
docker-machine env --swarm swarm-node0
docker-machine env --swarm swarm-manager
docker-machine env --swarm swarm-node1
docker-machine env --swarm swarm-node2
eval $(docker-machine env --swarm swarm-manager)
docker info
docker-machine ls
