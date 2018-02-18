#!/bin/bash

## TO RUN THIS ON REBOOT:
##    crontab -e
##    @reboot sh /home/user/script.sh

DOCKERCOUNT=$(sudo docker ps -a | wc -l)

#if dockers exsist; delte all of them
if [[ $DOCKERCOUNT > 0 ]]; then
  sudo docker stop $(sudo docker ps -a -q)
  sudo docker rm $(sudo docker ps -a -q)
fi

#create new dockers
for (( i = 80; i < 84; i++ )); do
  sudo docker run --restart=on-failure -d -p $i:80 web_docker:v1
done
