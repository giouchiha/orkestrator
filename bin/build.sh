#!/bin/bash

#
# script: build.sh
# author: jorge.medina@koolops.com.mx
# desc: Script to build the deployment environment based on ansible

#
# Requerements:
# available projects: local
# available environments: development, testing, production.

# Enable debug mode and log to file
export DEBUG=1
LOG=/var/log/build.log
[ -n "$DEBUG" ] && exec < /dev/stdin > $LOG 2>&1

# Bash debug mode
[ -n "$DEBUG" ] && set -x

# Stop on errors
set -e

# vars

PROJECT=$1
ENVIRONMENT=$2

# Functions

# Log function
log() {
    echo -n `date`
    echo -n " -- "
    echo $@
}

# help function
#help() {
#    cat <<EOF

#$0 [ --project local ] [ --environment development ]
#
#   --project  | -p          : Specifies the project name
#   --environment | -e       : Specifies the environment on that project
#
#EOF
#    exit 0
#}

# Abort function
abort() {
  echo "$@"
  log "$@"
  exit 1
}

# Pre build function
pre_build() {
  echo
  echo " *** Changing file permissions to project owner keys"
  echo
  echo $(date)
  chmod 600 .ssh/*
  echo
  echo
}

# Build function
build() {
  echo
  echo " *** Building CI/CD "$ENVIRONMENT" environment for "$PROJECT" project."
  echo
  # Replacing custom variables
  # We change the path at build time from vagrant/jenkins.
  sed -i \
    -e "s^%PROJECT%^$PROJECT^g" \
    -e "s^%ENVIRONMENT%^$ENVIRONMENT^g" \
    ansible.cfg inventory/$PROJECT/$ENVIRONMENT || abort "Error while replacing with sed s/%VARS%/\$VARS/g on ansible.cfg and inventory/$PROJECT/$ENVIRONMENT."
  echo
}

# main

# Pre Build process
pre_build

# Pre Build process
build
