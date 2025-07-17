#!/bin/bash

# Terraform Installation Script for Ubuntu/Debian
# Day 4 Lab - DEVCOR Scripts

echo "=========================================="
echo "Installing Terraform on Ubuntu/Debian"
echo "=========================================="

# Step 1: Update package index and install required packages
echo "Step 1: Updating package index and installing prerequisites..."
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

# Step 2: Download and add HashiCorp GPG key
echo "Step 2: Adding HashiCorp GPG key..."
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Step 3: Verify the GPG key fingerprint
echo "Step 3: Verifying GPG key fingerprint..."
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

# Step 4: Add HashiCorp repository to system
echo "Step 4: Adding HashiCorp repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Step 5: Update package index with new repository
echo "Step 5: Updating package index..."
sudo apt update

# Step 6: Install Terraform
echo "Step 6: Installing Terraform..."
sudo apt-get install terraform

# Step 7: Verify installation
echo "Step 7: Verifying Terraform installation..."
echo "=========================================="
terraform -help

echo "=========================================="
echo "Terraform installation completed!"
echo "Version:"
terraform version
echo "=========================================="
