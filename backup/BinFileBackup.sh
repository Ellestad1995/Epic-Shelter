#!/bin/bash
#rsynch will


######### BEFORE RUNNING #########
#eval`ssh-agent`
#ssh-add id_rsa
#cron krever at enviroment variablene stemmer med de som er i cron
######### BEFORE RUNNING #########

DEBUG=0;


if [[ DEBUG -eq 1 ]]; then            #DRY-RUN WITHOUT COPYING FILES

sudo  /usr/bin/rsync -aunv --progress /var/log/mysql/mysql-bin.* /backups/Binlogs

  echo "######   FOR THIS PROGRAM TO NOT PERFORM A DRY-RUN CHANGE DEBUG TO '0'   ######"

else                                 #COPY FILES TO DESTINATION

 sudo /usr/bin/rsync -au --progress /var/log/mysql/mysql-bin.* /backups/Binlogs

 echo "Backup is performed"
fi
