#!/bin/bash

#Installing Docker
sudo apt update
sudo apt install apt-transport-https -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce -y
sudo gpasswd -a ubuntu docker
sudo service docker enable


#Installing AWS_CLI
sudo apt install awscli -y

#Pending for Docker Image Pushing
sleep 120

#Pulling Docker image from ECR and running 
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 421279864461.dkr.ecr.eu-central-1.amazonaws.com/container-repo:latest
sudo docker run -d -p 3000:3000 421279864461.dkr.ecr.eu-central-1.amazonaws.com/container-repo:latest