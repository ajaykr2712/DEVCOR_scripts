#!/bin/bash

# Terraform Testing Script
# Day 4 Lab - DEVCOR Scripts

echo "=========================================="
echo "Testing Terraform Configuration"
echo "=========================================="

# Change to the directory containing main.tf
cd "$(dirname "$0")"

echo "Current directory: $(pwd)"
echo "Files in directory:"
ls -la

echo "=========================================="
echo "Step 1: Initialize Terraform"
echo "=========================================="
terraform init

echo "=========================================="
echo "Step 2: Validate Configuration"
echo "=========================================="
terraform validate

echo "=========================================="
echo "Step 3: Plan Configuration"
echo "=========================================="
terraform plan

echo "=========================================="
echo "Step 4: Apply Configuration"
echo "Note: This will make actual changes to the router"
echo "=========================================="
read -p "Do you want to apply the configuration? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    terraform apply
else
    echo "Skipping apply step."
fi

echo "=========================================="
echo "Step 5: Show current state"
echo "=========================================="
terraform show

echo "=========================================="
echo "To destroy the configuration later, run:"
echo "terraform destroy"
echo "=========================================="
