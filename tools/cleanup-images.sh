#!/bin/sh
# remove stopped containers
docker rm $(docker ps -a -q)
# clean all non-tagged images
docker rmi $(docker images -q -f dangling=true)
