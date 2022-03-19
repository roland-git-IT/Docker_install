#!/bin/bash

# Description: Install Docker
# Author: Roland Udo-Akang
# Date: 3/13/2022

echo "Beginning Docker Installation for CentOS..."
sleep 1

echo "Cleaning up the system..."
sleep 1
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine -you -y > /dev/null 2>&1

echo "Setting up docker repository..."
sleep 1
curl ifconfig.me > /dev/null 2>&1
if [ $? -ne 0 ]
then
echo "Unable to connect to internet."
exit
else
sudo yum install -y yum-utils > /dev/null 2>&1
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo > /dev/null 2>&1
fi

echo "Installing the docker engine..."
sleep 1
sudo yum install -y docker-ce docker-ce-cli containerd.io > /dev/null 2>&1

echo "Checking status of docker daemon..."
sleep 1
sudo systemctl status docker > /dev/null 2>&1
if [ $? -ne 0 ]
then
echo -e "Docker daemon not active\nStarting and enabling daemon. Please wait..."
sudo systemctl start docker > /dev/null 2>&1
sudo systemctl enable docker > /dev/null 2>&1
fi

ANSWER=none
echo -n "Do you wish to be added to the docker group? (yes or no) "
while [ $ANSWER = "none" ]
do
read ANSWER
if [ $ANSWER = "yes" ]
then
sudo usermod $USER -aG docker
echo "Added Successfully!"
sleep 1
else
echo -n "invalid input! type yes or no: "
ANSWER=none
fi
done

clear
echo "Docker Installation complete!"
