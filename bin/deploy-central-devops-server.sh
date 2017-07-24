#!/bin/bash

#
# script: deploy-central-devops-server.sh
# author: jorge.medina@koolops.com.mx
# desc: Deploys general roles, jenkins service and git client on central-devops servers.

# Enable debug mode and log to file
export DEBUG=1

# Bash debug mode
[ -n "$DEBUG" ] && set -x

# Stop on errors
set -e

# vars


# main
#

echo
echo "Deploying general roles, jenkins service and git client on central-devops servers."
echo

cd /etc/ansible

# Onliner
ansible-playbook /etc/ansible/central-devops-servers.yml --tags=name_resolution_hostname,name_resolution_hosts,system_settings,system_settings_timezone,shell_settings,shell_tools,clean_package_mgmt,reposetup_package_mgmt,rsyslog_service,openssh_service,ntp_service,jenkins_service,git_client,git_client_jenkins,git_client_ansible

# One run by role
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=name_resolution_hostname
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=name_resolution_hosts
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=system_settings
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=system_settings_timezone
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=shell_settings
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=shell_tools
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=clean_package_mgmt
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=reposetup_package_mgmt
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=rsyslog_service
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=openssh_service
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=ntp_service
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=jenkins_service
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=git_client
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=git_client_jenkins
#ansible-playbook /etc/ansible/central-devops-servers.yml --tags=git_client_ansible

#
# Post setup
#
echo
echo "Is this a local development enviroment based on vagrant?, if so, run postsetup.sh script in order to finish the CENTRAL DEVOPS deployment."
echo "For example: # . /vagrant/bin/postsetup.sh"

