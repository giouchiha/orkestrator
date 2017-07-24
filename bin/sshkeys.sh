#!/bin/bash

#
# script: sshkeys.sh
# author: jorge.medina@koolops.com.mx
# desc: Installs ansible ssh keys on vagrant development machines.

# Enable debug mode and log to file
export DEBUG=1
LOG=/var/log/sshkeys.log
[ -n "$DEBUG" ] && exec < /dev/stdin > $LOG 2>&1

# Bash debug mode
[ -n "$DEBUG" ] && set -x

# Stop on errors
set -e

# vars
LOCALUSER_NAME=vagrant
LOCALUSER_HOMEDIR=/home/$LOCALUSER_NAME
LOCALROOT_HOMEDIR=/root

# main

# Create ssh directory for local user
#mkdir -p $LOCALUSER_HOMEDIR/.ssh
#chmod 700 $LOCALUSER_HOMEDIR/.ssh

# Create ssh directory for root user
mkdir -p $LOCALROOT_HOMEDIR/.ssh
chmod 700 $LOCALROOT_HOMEDIR/.ssh

# Set SSH Authorized keys for local servers
#echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCoGR97akRp0IVZ4H6CoH4I0+dzIUCQVBamRJcaeBOawc7RKWqrEV/deOYdD+9W6ZAbKvwZXfunY5fuvT7yPXH0qeYJaw6ZKj0pD9QW5B4N0SocjoH5QX6LoYlCL3QkV8y+o3paliGhYI+Z61h1WberBIhptZLbpfH0MyTboaEXmtiL3kGZP1cRyx+bOuQoUht9KP9Mm2NJjZejf1Ldy4Tm/sgcM1FTnddnoaNurdw6gp9Ch7yKKmIrBSD1eHqZ+mKn+CeZ85DE8NXOVEFYMPRtFFl0OeFsS0kKlOE0ceiO1T4gRfVgcrcKnSFAX415tqa7cBAiwZb4mrXqjqlEGys6KdXlQ2RWDPzKlbqSmSA1f5fdoaCGywhhhRqMXNzaiYLZ/fRsNuxaDMZH6Bc8N5RrS6ufWC2fZ2B0FnUTHAWbL6HKLdE6tExYQMvc8Xqc9Kwbdyg/Hrs4EwTdptu9SvE+MLh4W+d9YlrOSP/9FgLNa+RRngp1XXKm/ER2JdTw03CgHkkqJjfSFZB+k0oBWclO3aW57TM0pW58fKX6vMPX5kVETJETMs4NWVe7sVn1zv2aCppzkQAc4PomSETrtgNx+Jxn7+mSJHADYqgsO+RX04eI8UPqMVzL9Moh6dmtixA1a+U1rnGu4BEGcLBtCX8i98SBrSTdq72H2fpsHXuyJw== SSH Key for ubuntu@dev.example.com" > $LOCALUSER_HOMEDIR/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnPhMu08IKfIzWv6mweGfeZEKf97s1F++7/QZczvOUbGXAo0w9GhBjBuDLtJopXEhM1ZZFLwXS50iWkb3sXbiJ/Oe8XqBJP6PzL9EBHHv0xYp7tDpiSxQTfoNnqDmqlOS9KiP4ehWr1ICzoQjFTPw65u+1YsT501gTXTAFd2hRddjH+i1OgI/nYwxcXDH5HM7wqP5HVjluo7EFKiiMpsZh9gPiZse4yDilh1389Cf6PyC3/33f8RAsCip5RPtxZwmM+mRJ6pW4giKTWspPJW8QhSwX7Pa7CPOB6qYY0TOztfe/RKI2gNSGlUugl+VqnpdwQ41FL4jiW04/Ciqz4ctinzuBL01wYGxngE8Ugta7aFJv6R5E4uRCemseUT5MGEQbBeKjuwLd7HJ2WdwqvhIpCQiKWzlcm1wkvV3t+KY69L2WoYOQlRpxyIyZOfQbKlg3aoeBs/1bfB/YIJlAKMUCPjmIqhUka4d34vvWKAXcW5WyvrYzdKkPqtOVIMzaFOI62UuXx+ljXEo4p4vCowG3jCHjCi51cMr5TtVUGlHadiVaQiPpBaFLu4XgjS2DSh23oWombZg1aW0yrEOiBZqFVCbqow0PiBJXaAMnlIHS7s4K7u9o5K483g/Tazngy0LNU00uW/b3H0qbGz6M3k48mjZIA5Pweov2TcvSp9gpJw== SSH key for root@dev.infra.admin.example.2017" > $LOCALROOT_HOMEDIR/.ssh/authorized_keys

# Setting up file permissions
#chmod 600 $LOCALUSER_HOMEDIR/.ssh/authorized_keys
chmod 600 $LOCALROOT_HOMEDIR/.ssh/authorized_keys
