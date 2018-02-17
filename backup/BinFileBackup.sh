#!/bin/bash
#rsynch will


######### BEFORE RUNNING #########
#eval`ssh-agent`
#ssh-add id_rsa
#cron krever at enviroment variablene stemmer med de som er i cron
######### BEFORE RUNNING #########

DEBUG=1;


if [[ DEBUG -eq 1 ]]; then            #DRY-RUN WITHOUT COPYING FILES

  /usr/bin/rsync -aunv -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
  --progress /var/log/mysql/mysql-bin.* ubuntu@10.10.1.78:/home/ubuntu/backups/binlogs

  echo "######   FOR THIS PROGRAM TO NOT PERFORM A DRY-RUN CHANGE DEBUG TO '0'   ######"

else                                 #COPY FILES TO DESTINATION

  /usr/bin/rsync -au -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
  --progress /var/log/mysql/mysql-bin.* ubuntu@10.10.1.78:/home/ubuntu/backups/binlogs

 echo "Backup is performed"
fi
