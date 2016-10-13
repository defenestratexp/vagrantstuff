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

# Install mysql-client #
##################
echo "# MySQL Client Installation #"
echo "#############################"
echo ""
apt-get -y install mysql-client

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

# Copy vimrc #
##############
wget -O /home/sthompson/.vimrc https://www.dropbox.com/s/21z2qquqk0n9py8/vimrcplugins?dl=0

# Install vim plugins #
#######################
echo "#!/bin/bash" > /home/sthompson/bin/vimplugin
echo "vim +PluginInstall +qall" >> /home/sthompson/bin/vimplugin
chown sthompson:sthompson/home/sthompson/bin/vimplugin
sudo -H -u sthompson /home/sthompson/bin/vimplugin

chown -R sthompson:sthompson /home/sthompson/*

# Epoch time after last config #
################################
finishepoch=`date +%s`

differenceinseconds=$((startingepoch - finishepoch))
divider=60
packageconfigtime=$((differenceinseconds / divider))
echo "Package configuration took $packageconfigtime minutes"
