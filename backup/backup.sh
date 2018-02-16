#!/bin/bash

######### BEFORE RUNNING #########
#eval`ssh-agent`
#ssh-add id_rsa
#cron krever at enviroment variablene stemmer med de som er i cron
######### BEFORE RUNNING #########

TMP=$(ls /home/ubuntu/backups)
DIRSTAT=$?

if [[ DIRSTAT -ne 0 ]]; then
  mkdir /home/ubuntu/backups
fi

#Lage en dump fil med riktig navn
sudo mysqldump --opt --master-data=2 --flush-logs \
--all-databases > /home/ubuntu/backups/backup.$(date +%d_%m_%y_%R).sql

LATESTMODFILE=$(ls -1 -t /home/ubuntu/backups/ | head -1)

#Sende alt til backupvmen --> scp med privatekey
scp -r -v -o StrictHostKeyChecking=no /home/ubuntu/backups/$LATESTMODFILE ubuntu@10.10.1.78:/home/ubuntu/backups
