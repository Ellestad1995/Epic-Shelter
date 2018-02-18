#!/bin/bash -x
HOST=$1
FLOATINGIP="10.212.136.46"
NOTIFYEMAIL=bookfacegruppe02@gmail.com
EXSISTINGHOST=$(openstack server list | grep 10.212.136.146 | awk '{print $4}')
#Add the HOST (parameter) to a local variable

#går ut i fra at det allerde finnes en "connection" til openstack via API

#finne ut hvilken maskin som har gjeldene floating IP

#fjerne floating IP fra maskina som har den
openstack ip floating remove $FLOATINGIP $EXSISTINGHOST
STATUSREMOVE=$?

#tildele floating IP til $HOST som er parameter
openstack ip floating add $FLOATINGIP $HOST
STATUSADD=$?

#Sende mail
if [[ STATUSADD -eq 1 ]]; then
  #CAN NOT ADD IP
  echo "$FLOATINGIP can not be assigned to $HOST at $(date +%d_%m_%y_%R)" | mail -s "ERROR: floating IP" $NOTIFYEMAIL
elif [[ STATUSREMOVE -eq 1 ]]; then
  #CAN NOT REMOVE IP
  echo "$FLOATINGIP can not be removed from $EXSISTINGHOST at $(date +%d_%m_%y_%R)" | mail -s "ERROR: floating IP" $NOTIFYEMAIL
else
  #BOTH PASSED. EVERYTHING WORKED
  echo "Floating IP: $FLOATINGIP have been assigned to $HOST at $(date +%d_%m_%y_%R)" | mail -s "New floating IP" $NOTIFYEMAIL
fi
