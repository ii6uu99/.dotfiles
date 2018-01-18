#!/bin/bash
docker exec -ti -u root $(docker ps | grep supervisor | cut -d " " -f 1) /bin/bash
