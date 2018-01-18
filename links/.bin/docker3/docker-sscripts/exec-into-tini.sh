#!/bin/bash
docker exec -ti --user root $(docker ps | grep jupyter | cut -f1 -d ' ') /bin/bash
