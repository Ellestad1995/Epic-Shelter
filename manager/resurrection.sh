#!/bin/bash

#Made by Joakim Ellestad, joakine@stud.ntnu.no

#Using the openstack api to check for vm


NOTIFYEMAIL=bookfacegruppe02@gmail.com
SMSEMAIL=NULL
SENDEREMAIL=alert@localhost
SERVER="$HOSTNAME"
IFSOLD=$IFS

#Make sure openstack is going to work
source /home/ubuntu/IMT3003_V18_group02.sh
echo "$HOSTNAME is running a cron job- Resurrection " | /usr/bin/mail -s "Resurrection is started!" -r "$SENDEREMAIL" "$NOTIFYEMAIL"

#Getting all servers
VMSHUTOFF="$(openstack server list | grep SHUTOFF)"

#For all the vm that is shutoff we need to boot them back up and alert admin
#Change the IFS environment variable to newline to be able to loop
IFS=$'\n'
for SHUTOFF in $VMSHUTOFF
do

#What virtual machine is this?
#awk -v var="$variable" 'BEGIN {print var}'
ID="$( echo "$SHUTOFF" | awk '{ print $2 }\')"
NAME="$( echo "$SHUTOFF" | awk '{ print $4 }\' )"
STATUS="$( echo "$SHUTOFF" | awk '{ print $6 }\' )"
NETWORK="$( echo "$SHUTOFF" | awk '{ print $8 }\' )"

if [ "$STATUS" = "SHUTOFF" ]
then
#try restarting
openstack server start $NAME
S=$?
  if [ $S -ne 0 ]
  then
    #Failed
    echo "$NAME is $STATUS - did attempt server start" | /usr/bin/mail -s "Loosing kyrrecoins" -r "$SENDEREMAIL" "$NOTIFYEMAIL"
  fi
fi

done

#Restore IFS
IFS=$IFSOLD
