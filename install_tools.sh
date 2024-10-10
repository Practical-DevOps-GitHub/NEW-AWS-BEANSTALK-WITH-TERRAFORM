#!/bin/bash

# Update package lists
sudo apt-get update

# Install prerequisites
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg software-properties-common unzip

# Install AWS CLI version 2
echo "Installing AWS CLI version 2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws_version=$(aws --version)
echo "AWS CLI installed: $aws_version"
rm -rf awscliv2.zip aws

# Install Terraform
echo "Installing Terraform..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y terraform
terraform_version=$(terraform -v)
echo "Terraform installed: $terraform_version"

echo "All installations completed successfully."