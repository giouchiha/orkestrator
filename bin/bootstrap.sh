#!/bin/bash

#
# script: bootstrap.sh
# author: jorge.medina@koolops.com.mx
# desc: Installs ansible on ubuntu from ppa & prepares the enviroment for infrastructure, application and database deployments.

# Enable debug mode and log to file
export DEBUG=1
LOG=/var/log/bootstrap.log
[ -n "$DEBUG" ] && exec < /dev/stdin > $LOG 2>&1

# Bash debug mode
[ -n "$DEBUG" ] && set -x

# Stop on errors
set -e

# vars

# Disable errors from dpkg-reconfigure
export DEBIAN_FRONTEND=noninteractive

# main

echo
echo "Updating apt lists."
sudo apt-get -qq update
echo
echo "Installing basic requirements."
sudo apt-get -qq install vim curl git ssh aptitude update-notifier-common
echo

echo "Installing software-properties-common."
sudo apt-get -qq install software-properties-common
echo

echo
echo "Installing Ansible dependencies."
sudo apt-get install -qq -y python-yaml python-jinja2 python-paramiko python-crypto python-simplejson
echo

echo
echo "Installing ansible from ansible ppa repository."
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get -qq update
sudo apt-get -qq install ansible
echo

echo
echo "Creating and changing ownership and permissions for /var/lib/ansible."
mkdir -p /var/lib/ansible/retries
chown -R root:adm /var/lib/ansible
chmod 770 /var/lib/ansible/retries
echo "Changing ansible ownership and permissions for /var/log/ansible"
mkdir -p /var/log/ansible
chown root:adm /var/log/ansible
chmod 770 /var/log/ansible
touch /var/log/ansible/ansible.log
chown root:adm /var/log/ansible/ansible.log
chmod 660 /var/log/ansible/ansible.log
echo
