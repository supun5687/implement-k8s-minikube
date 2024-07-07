#!/bin/bash

# Function to print messages
print_message() {
  echo "======================================="
  echo $1
  echo "======================================="
}

# Updating system packages and installing dependencies
print_message "Updating system packages and installing dependencies"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl wget apt-transport-https

# Installing Docker
print_message "Installing Docker"
sudo apt-get install docker.io -y
print_message "docker-user"
#sudo usermod -aG docker $USER && newgrp docker
sudo usermod -aG docker $USER

# Check if the user has been added to the docker group
print_message "Checking Docker Group Membership"
if id -nG "$USER" | grep -qw "docker"; then
  echo "$USER is in the docker group"
else
  echo "$USER is not in the docker group. Please log out and log back in to apply the group membership."
fi


# Installing Minikube
print_message "Installing Minikube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod 755 minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube

# Checking Minikube version
print_message "Minikube Version"
minikube version

# Installing kubectl utility
print_message "Installing kubectl"
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Printing kubectl version
print_message "kubectl Version"
kubectl version -o yaml

# Starting Minikube with Docker driver
print_message "Starting Minikube"
minikube start --driver=docker

# Printing Minikube status
print_message "Minikube Status"
minikube status

# Printing Kubernetes cluster information
print_message "Kubernetes Cluster Info"
kubectl cluster-info
