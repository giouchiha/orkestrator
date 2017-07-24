#!/bin/bash

#
# script: postsetup.sh
# author: jorge.medina@koolops.com.mx
# desc: Post ansible setup from git and  jenkins integration.

# Enable debug mode and log to file
export DEBUG=1

# Bash debug mode
[ -n "$DEBUG" ] && set -x

# Stop on errors
set -e

# vars
GIT_INFRA_REPO=https://github.com/koolops/orkestrator.git
GIT_INFRA_BRANCH=master
INFRA_TMP=/tmp/infra

# functions

# main

echo
echo "Cloning infrastructure code on staging area."
echo
git clone -b ${GIT_INFRA_BRANCH} --single-branch ${GIT_INFRA_REPO} ${INFRA_TMP}

echo
echo "Build development enviroment for local project on ${INFRA_TMP}."
echo
cd ${INFRA_TMP}
git checkout -- ansible.cfg inventory/local/development
bin/build.sh local development

echo
echo "Test check for development enviroment for local project on ${INFRA_TMP}."
echo
cd ${INFRA_TMP}
ansible-playbook central-site.yml --syntax-check

echo
echo "Unlink ansible infrastructure data from /vagrant."
echo
if [ -L /etc/ansible ]; then
  rm -rf /etc/ansible
fi

echo
echo "Deploying infrastructure code on /etc/ansible."
echo
cp -a /tmp/infra /etc/ansible

echo
echo "Changing ownership and permissions for /etc/ansible."
chown -R jenkins:jenkins /etc/ansible
chmod 750 /etc/ansible

echo
echo "Changing ownership and permissions for /etc/ansible/.ssh."
echo
chmod 750 /etc/ansible/.ssh
chmod 600 /etc/ansible/.ssh/*

echo
echo "Changing ownership and permissions for /var/lib/ansible."
echo
chown -R root:jenkins /var/lib/ansible
chmod -R 770 /var/lib/ansible
chmod 770 /var/lib/ansible/retries

echo
echo "Changing ansible ownership and permissions for /var/log/ansible"
echo
chown root:jenkins /var/log/ansible
chmod 770 /var/log/ansible
chown root:jenkins /var/log/ansible/ansible.log
chmod 660 /var/log/ansible/ansible.log

echo
echo "Changing ownership and permissions for jenkins jobs and config files."
service jenkins stop
chown jenkins:jenkins /var/lib/jenkins/*.xml
chown -R jenkins:jenkins /var/lib/jenkins/jobs
service jenkins start

