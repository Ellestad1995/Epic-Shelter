# Epic-Shelter
Automated backup and recovery of medium sized OpenStack environment


##Use Cases

- Check the health of running vm - And report to admin
- Check the health of running docker instances on vm - And report to admin
- Scale new backend-vm environment (docker, config files) automatically - And report to admin
- Delete vm and create new with correct config files - And report to admin
- Create new front-end (haproxy) and change floating-ip - And report to admin


##Requirements

```
apt-get install python-openstackclient
```
Openstack Credentials are necessary in the config file

```
source ./IMT3441_V18_groupX.sh
```
Add to .bashrc to avoid running this command every time.
