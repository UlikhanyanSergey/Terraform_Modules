#!/bin/bash

#Installing Docker
sudo apt update
sudo apt install apt-transport-https -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce -y
sudo gpasswd -a ubuntu docker
newgrp docker
sudo service docker enable


#Installing AWS_CLI
sudo apt install awscli -y


#Creating Dockerfile
sudo mkdir -p /app
cd /app
git clone https://github.com/brainscalesolutions/brainscale-simple-app.git

cat << 'DOCKERFILE_CONTENT' > /app/Dockerfile
 # Use the Node.js image
FROM node:14

# Set the working directory
WORKDIR /app

# Install the application dependencies
RUN npm install
RUN npm install express ejs

# Copy the app.js file to the container
COPY brainscale-simple-app/app.js .

# Copy the views directory to the container
COPY brainscale-simple-app/views ./views

# Expose port 3000
EXPOSE 3000

# Start the Node.js application
CMD ["node", "app.js"]
DOCKERFILE_CONTENT


#Building Docker Image
sudo docker build -t my_app:latest .


#Pushing Docker Image
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 421279864461.dkr.ecr.eu-central-1.amazonaws.com
docker tag my_app:latest 421279864461.dkr.ecr.eu-central-1.amazonaws.com/container-repo:latest
docker push 421279864461.dkr.ecr.eu-central-1.amazonaws.com/container-repo:latest