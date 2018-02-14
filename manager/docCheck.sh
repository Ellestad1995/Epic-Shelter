#!/bin/bash
#Made by Joakim Ellestad, joakine@stud.ntnu.no

NOTIFYEMAIL=bookfacegruppe02@gmail.com
SMSEMAIL=NULL
SENDEREMAIL=alert@localhost
SERVER="$HOSTNAME"
IFSOLD=$IFS


#Make sure openstack is going to work
source /home/ubuntu/IMT3003_V18_group02.sh

#Getting all servers which belong to our account
VMS="$(openstack server list | grep IMT3003)"

#For all the vm with docker installed check if docker is running
#Change the IFS environment variable to newline to be able to loop
IFS=$'\n'
for ACTIVE in $VMS
do
ID="$( echo "$ACTIVE" | awk '{ print $2 }\')"
NAME="$( echo "$ACTIVE" | awk '{ print $4 }\' )"
STATUS="$( echo "$ACTIVE" | awk '{ print $6 }\' )"
NETWORK="$( echo "$ACTIVE" | awk '{ print $8 }\' )"
#Getting the ip of the vm
IP="$(grep -o "10.10.[0-9]\+\.[0-9]\+\ ")"
#Should only evaluate docker containers
DOCKERSTATUS="$(ssh ubuntu@$IP service docker status)"
#If docker exists
LOADED="$(echo "$DOCKERSTATUS" | grep Loaded )"
#Find either: Loaded, not-found
STATUS="$( echo "$LOADED" | awk '{print $2 }\')"
if [[ STATUS = "not-found" ]]; then
  continue
fi
#Its loaded but is it running?
RUNNING="$(echo "$DOCKERSTATUS" | grep Active )"
ACTIVE="$( echo "$LOADED" | awk '{print $2 }\')"
if [[ STATUS = "inactive" ]]; then
  #It's not running. Try to start it
START="$(ssh ubuntu@$IP service docker start)"

fi



done
