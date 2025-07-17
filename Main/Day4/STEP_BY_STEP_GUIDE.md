# Step-by-Step Lab Instructions
# Day 4: Terraform with Cisco IOS XE

## Step 1: Install Terraform

### Manual Installation Commands:
Run these commands in your Ubuntu/Linux terminal:

```bash
# Update package index and install prerequisites
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

# Download and add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Verify GPG key fingerprint
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

# Add HashiCorp repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package index
sudo apt update

# Install Terraform
sudo apt-get install terraform

# Verify installation
terraform -help
```

### Automated Installation:
Alternatively, you can use the provided script:
```bash
./install_terraform.sh
```

## Step 2: Configure CSR1000v Router in EVE-NG

### Router Specifications:
- **Model**: CSR1000v 3.x
- **CPU**: 2 cores
- **RAM**: 4096 MB
- **QEMU NIC**: virtio-net-pci

### Configuration Commands:
```cisco
enable
configure terminal

hostname CSR4
interface gi1
ip address 10.255.1.144 255.255.255.0
description Connected to MGMT
no shutdown
exit

# Create admin user with privilege 15 for Terraform authentication
username admin privilege 15 secret cisco

# Enable authentication for HTTP/HTTPS
ip http authentication local

ip http server
ip http secure-server

restconf

end
write memory
```

### Verification Commands:
```cisco
show ip interface brief
show restconf
show ip http server status
show running-config | include username
show running-config | section ip http
```

## Step 3: Create Terraform Configuration

The `main.tf` file has been created with the following configuration:

```hcl
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
```

## Step 4: Test Terraform Configuration

### Manual Testing Commands:
Navigate to the Day4 directory and run:

```bash
cd /Users/aponduga/Desktop/Work/2/DEVCOR_scripts/Main/Day4

# Initialize Terraform (downloads provider plugins)
terraform init

# Validate configuration syntax
terraform validate

# Create execution plan
terraform plan

# Apply configuration (creates loopback interface)
terraform apply

# View current state
terraform show

# Clean up (removes loopback interface)
terraform destroy
```

### Automated Testing:
Use the provided script:
```bash
./test_terraform.sh
```

## Important Notes:

1. **User Authentication**: The configuration creates an admin user with privilege 15 (full administrative access) for Terraform authentication.

2. **Security**: The configuration uses `insecure = true` for lab purposes. In production, use proper SSL certificates.

3. **Credentials**: Default credentials (admin/cisco) are used. Change these in production environments.

4. **HTTP Authentication**: Local authentication is enabled for HTTP/HTTPS access to support RESTCONF API calls.

5. **Network Connectivity**: Ensure the management interface (10.255.1.144) is reachable from your Terraform host.

6. **RESTCONF**: Make sure RESTCONF is enabled on the router for API communication.

## Troubleshooting:

- If Terraform cannot connect to the router, verify the IP address and credentials
- Check that the admin user is configured with privilege 15: `show running-config | include username`
- Verify HTTP authentication is enabled: `show running-config | section ip http`
- Check that RESTCONF is enabled and HTTP/HTTPS servers are running
- Ensure no firewall rules are blocking the connection
- Verify the router is accessible via ping before running Terraform

## Expected Outcome:

After successful execution, you should see:
- A new loopback100 interface on the CSR1000v router
- IP address 192.168.100.1/24 assigned to the interface
- Interface description showing it was configured by Terraform
