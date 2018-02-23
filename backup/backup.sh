#!/bin/bash -x

######### BEFORE RUNNING #########
  # Kreves at man har et eksternt mountpoint som man backer up til
######### BEFORE RUNNING #########

TMP=$(ls /backups/Full/)
DIRSTAT=$?

if [[ DIRSTAT -ne 0 ]]; then
  sudo mkdir /backups/Full
fi

#Lage en dump fil med riktig navn

NAME="backup.$(date +%d_%m_%y_%R).sql"

sudo mysqldump --opt --master-data=2 --flush-logs \
--all-databases > /home/ubuntu/$NAME

sudo mv /home/ubuntu/$NAME /backups/Full
