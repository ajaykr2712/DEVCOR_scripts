# Day 4: Terraform with Cisco IOS XE

This directory contains the Terraform configuration and instructions for managing Cisco IOS XE devices using Terraform.

## Overview

This lab demonstrates how to use Terraform to manage network infrastructure, specifically configuring Cisco CSR1000v routers using the IOS XE provider.

## Prerequisites

- EVE-NG environment
- CSR1000v 3.x router image
- Basic understanding of Terraform concepts

## Steps Covered

1. **Terraform Installation** - Install Terraform on Ubuntu/Linux systems
2. **CSR1kv Configuration** - Basic router setup in EVE-NG
3. **Terraform Configuration** - Create main.tf with IOS XE provider
4. **Testing and Deployment** - Validate and apply Terraform configuration

## Files in this directory

- `main.tf` - Terraform configuration file for IOS XE
- `install_terraform.sh` - Script to install Terraform
- `router_config.txt` - Basic CSR1kv configuration commands

## Lab Environment

- Router: CSR1000v 3.x
- Management IP: 10.255.1.144/24
- CPU: 2 cores
- RAM: 4096 MB
- NIC Type: virtio-net-pci

## Usage

Follow the step-by-step instructions in each file to complete the lab exercises.
