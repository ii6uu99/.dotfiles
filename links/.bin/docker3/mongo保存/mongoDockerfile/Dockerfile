# Dockerizing MongoDB: Dockerfile for building MongoDB images
# Based on ubuntu:latest, installs MongoDB following the instructions from:
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

# Format: FROM    repository[:version]
FROM       ubuntu:latest

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER M.Y. Name jameshounshell@gmail.com

# Update apt-get sources AND install MongoDB
RUN apt-get update && apt-get install -y mongodb

# Create the MongoDB data directory
RUN mkdir -p /data/db

# Expose port 27017 from the container to the host
EXPOSE 27017

# Set usr/bin/mongod as the dockerized entry-point application
ENTRYPOINT ["/usr/bin/mongod"]

# command to start container
# docker run -p 27017:27017 --name mongo -d ishtargate/mongo /etc/bin/mongod --smallfiles