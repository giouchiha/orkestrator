#!/bin/bash

#
# script: deploy-ansible-keys.sh
# author: jorge.medina@koolops.com.mx
# desc: Copy ssh root keys to server
#

# vars
PROJECT=$1
ENVIROMENT=$2
INVENTORY=inventory/${PROJECT}/${ENVIROMENT}
SERVER=$3
USER=$4

# main

echo "Moving to ansible working directory."
#cd /etc/ansible

echo "Running playbook extra_plays/copy-ssh-key-to-server.yml over $SERVER server."

# When server already have a root user with password
#ansible-playbook -i $INVENTORY extra_plays/copy-ssh-key-to-server.yml --limit=$SERVER -e "ansible_ssh_user=$USER" -k

# When server with user vagrant and sudo
ansible-playbook -i $INVENTORY extra_plays/copy-ssh-key-to-server.yml --limit=$SERVER -e "ansible_ssh_user=$USER" -k -s -K

# For AWS
#ansible-playbook -i $INVENTORY extra_plays/copy-ssh-key-to-server.yml --limit=$SERVER -e "ansible_ssh_user=$USER" -e "ansible_ssh_private_key_file=/etc/ansible/.ssh/%PROJECT_%ENVIROMENT%_infra.pem" -s -K
