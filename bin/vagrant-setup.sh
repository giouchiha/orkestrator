#!/bin/bash

#
# script: vagrant-setup.sh
# author: jorge.medina@koolops.com.mx
# desc: Setup vagrant inside a machine created by packer

# Enable debug mode and log to file
export DEBUG=1
LOG=/var/log/vagrant-setup.log
[ -n "$DEBUG" ] && exec < /dev/stdin > $LOG 2>&1

# Bash debug mode
[ -n "$DEBUG" ] && set -x

# Stop on errors
#set -e

# vars

# Disable errors from dpkg-reconfigure
export DEBIAN_FRONTEND=noninteractive

# main

# Install base packages for Vagrant and Virtualbox guest additions
apt-get -qq update
apt-get -qq -y install cryptsetup build-essential libssl-dev libreadline-dev zlib1g-dev linux-source linux-headers-$(uname -r) dkms nfs-common

# Setup insecure vagrant user ssh key
/bin/mkdir /home/vagrant/.ssh
/bin/chmod 700 /home/vagrant/.ssh
/usr/bin/curl -L -o /home/vagrant/.ssh/id_rsa https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant
/usr/bin/curl -L -o /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
/bin/chown -R vagrant:vagrant /home/vagrant/.ssh
/bin/chmod 0600 /home/vagrant/.ssh/*

# Add vagrant user to privileged ones
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
#sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Disable DNS checks so we can speedup ssh connections
/bin/echo '# Local settings' >> /etc/ssh/sshd_config
/bin/echo 'UseDNS no' >> /etc/ssh/sshd_config
/bin/echo 'GSSAPIAuthentication no' >> /etc/ssh/sshd_config

# Install virtualbox guest additions
#apt-get -qq update
#apt-get -qq -y install linux-headers-$(uname -r) build-essential dkms

# Mount iso
VER=$(cat /home/vagrant/.vbox_version)
mount -o loop /home/vagrant/VBoxGuestAdditions_$VER.iso /media/cdrom/

# Run vbox guest additions installer
sh /media/cdrom/VBoxLinuxAdditions.run

# Umount iso
umount /media/cdrom/

# Remove iso file
rm -rf /home/vagrant/VBoxGuestAdditions_$VER.iso

#
# Cleanup tasks
#

# Remove unneeded packages.
apt-get -y autoremove
apt-get -y remove --purge \
 ppp \
 pppconfig \
 pppoeconf \
 cpp \
 gcc \
 g++ \
 libx11-data \
 xauth \
 libxmuu1 \
 libxcb1 \
 libx11-6 \
 libxext6 \
 linux-source

# Remove uneeded packages (by regex).
apt-get -y remove '.*-dev$'

# Clean apt cache
apt-get -y autoremove
apt-get -y clean

# Zero out the drive
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Cleanup shell history
#cat /dev/null > ~/.bash_history && history -c && exit
cat /dev/null > ~/.bash_history && history -c
