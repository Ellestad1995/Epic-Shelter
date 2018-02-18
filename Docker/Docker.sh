#!/bin/bash

DOCKERCOUNT=$(sudo docker ps -a | wc -l)

#if dockers exsist; delte all of them
if [[ $DOCKERCOUNT > 0 ]]; then
  docker rm $(docker ps -a -q)
fi

#create new dockers
for (( i = 80; i < 83; i++ )); do
  sudo docker run --restart=on-failure -d -p $i:80 web_docker:v1
done
