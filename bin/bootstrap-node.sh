#!/bin/bash

#
# script: bootstrap-node.sh
# author: jorge.medina@koolops.com.mx
# desc: Installs basic requirements for ansible managed nodes.

# Enable debug mode and log to file
export DEBUG=1
LOG=/var/log/bootstrap-node.log
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
