# Terraform Configuration for Cisco IOS XE
# Day 4 Lab - DEVCOR Scripts
# This configuration creates a loopback interface on CSR1000v router

terraform {
  required_providers {
    iosxe = {
      source = "CiscoDevNet/iosxe"
      version = "0.5.10"
    }
  }
}

provider "iosxe" {
  username = "admin"
  password = "cisco"
  url = "https://10.255.1.144"
  insecure = true
}

resource "iosxe_interface_loopback" "loopback" {
  name = 100
  description = "Configured by Abhijit using Terraform"
  shutdown = false
  ipv4_address = "192.168.100.1"
  ipv4_address_mask = "255.255.255.0"
}
