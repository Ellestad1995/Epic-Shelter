#!/bin/bash -x

IP=$(openstack server list | grep docker  | awk -F = '{print $2}' | awk '{print $1}')
cp haproxy.cfg.header haproxy.cfg

for i in $IP; do
	echo "server dockerswarmNode $i:80 check" >> haproxy.cfg
done

cat haproxy.cfg.footer >> haproxy.cfg

scp haproxy.cfg ubuntu@10.10.0.158:/home/ubuntu/haproxy.cfg
ssh -o StrictHostKeyChecking=no ubuntu@10.10.0.158  "sudo rm /etc/haproxy/haproxy.cfg; \
sudo cp /home/ubuntu/haproxy.cfg /etc/haproxy/ ; \
rm /home/ubuntu/haproxy.cfg; \
sudo service haproxy restart"
rm haproxy.cfg
