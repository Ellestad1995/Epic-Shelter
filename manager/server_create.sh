#!/bin/bash -x
#Made by Joakim Ellestad, joakine@stud.ntnu.no
#Creates a new virtualmachine using openstack api
#Get the ip address of the newly created vm
#using scp copy over necessary files
#Using ssh build docker and run
#Using the ip add a new entry to loadbalancer for haproxy and restart it


#| af832c2e-2368-4e87-9f0e-196a4e82c70c | Ubuntu Server 16.04 LTS (Xenial Xerus) amd64 | active |
#before running this script ensure the following
#source openstackfile
#eval`ssh-agent`
#ssh-add id_rsa

USER="ubuntu"

#Get the falvor of ubntu we want
UBUNTUFLAVOR="af832c2e-2368-4e87-9f0e-196a4e82c70c"
FLAVOR="0a4b6072-3170-447a-8ac1-89562fd1c042"
KEY="manager_pub_key"
NETID="e634af77-a389-4dee-992d-09d8402eb3f4"
AVAILZONE="nova"
USERDATAPATH="/home/ubuntu/userdata.sh"
FILEINJECT="/home/ubuntu/DockerDirectory"

SERVER="$(openstack server create \
--image $UBUNTUFLAVOR \
--flavor $FLAVOR  \
--key-name $KEY \
--user-data $USERDATAPATH \
--availability-zone $AVAILZONE \
--nic net-id=$NETID \
--wait \
backup )"

STATUS="$( echo $SERVER | grep status | awk '{print $4 }\' )"
ID="$( echo $SERVER | grep id | awk '{print $4 }\' )"
IP="$( echo $SERVER | grep addresses | grep -o "10.10.[0-9]\+\.[0-9]\+\ " | awk '{print $1 }\' )"



echo "Successfully created virtualmachine $ID @ $IP"
