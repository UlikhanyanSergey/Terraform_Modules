#!/bin/bash

#Use your own variables
AWS_REGION="eu-central-1"
AWS_ACCOUNT_ID="421279864461"
ECR_REPOSITORY="container-repo"
IMAGE_TAG="latest"

home="/home/"
user=$(whoami)
projectpath="/Downloads/Terraform_Modules/"
path="$home$user$projectpath"
cd ${path}

# Authenticate with ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Delete the image from ECR
aws ecr batch-delete-image --repository-name $ECR_REPOSITORY --image-ids imageTag=$IMAGE_TAG --region $AWS_REGION

# Destroy the infrastructure
terraform destroy