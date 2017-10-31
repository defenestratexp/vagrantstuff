#!/usr/bin/env bash

# Epoch time before system updates #
startingepoch=`date +%s`

# Set the install directory #
#############################
workingdir=`pwd`

# Add additional repositories #
###############################

# System Update #
#################

echo "# Will now perform a system update #"
echo "####################################"
echo ""
apt-get -y update

# Install java #
################
echo "# Installing OpenJDK #"
echo "######################"
echo ""
apt-get -y install openjdk-7-jre

# Install additional sysadmin tools #
#####################################
echo "# Installing sysadmin tools #"
echo "#############################"
apt-get -y install vim vim-nox htop sysstat nmap lsof git ssh-askpass

# Create a non-vagrant user #
#############################
echo "# Will run useradd to create a non-vagrant user #"
echo "#################################################"
echo ""

# Groups #
##########
groupadd -f admins
groupadd -f adm
groupadd -f vboxuser
groupadd -f vagrant

# my user #
###########
useradd -d /home/sthompson -m -s /bin/bash -G admins,adm,vboxuser,vagrant sthompson

# Local sudo Access #
#####################
echo "sthompson ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


# Extra directories #
#####################
mkdir /home/sthompson/bin
mkdir -p /home/sthompson/build/{repos,src,bin}
mkdir /home/sthompson/tmp
