#!/bin/bash

#Using the openstack api to check for vm


NOTIFYEMAIL=bookfacegruppe02@gmail.com
SMSEMAIL=NULL
SENDEREMAIL=alert@localhost
SERVER="$HOSTNAME"
IFS.OLD=$IFS


#Getting all servers
VMSHUTOFF="$(openstack server list | grep SHUTOFF)"

#For all the vm that is shutoff we need to boot them back up and alert admin
#Change the IFS environment variable to newline to be able to loop
IFS=$'\n'
for SHUTOFF in $(cat $VMSHUTOFF)
do

#What virtual machine is this?
ID="$(awk \'{ print $2}\' )"
NAME="$(awk \'{ print $4}\' )"
STATUS="$(awk \'{ print $6}\' )"
NETWORK="$(awk \'{ print $8}\' )"

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
IFS=$IFS.OLD
