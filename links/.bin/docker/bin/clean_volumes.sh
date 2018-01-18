#!/bin/bash

docker volume rm $(docker volume ls -qf dangling=true)

#docker volume ls -qf dangling=true | xargs -r docker volume rm

exit 0
