# Terraform Installation for macOS
# Day 4 Lab - DEVCOR Scripts

## Method 1: Using Homebrew (Recommended)

If you have Homebrew installed:
```bash
# Install Terraform using Homebrew
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Verify installation
terraform version
```

## Method 2: Manual Installation (Used in this test)

```bash
# Download Terraform for macOS
curl -fsSL https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_darwin_amd64.zip -o terraform.zip

# Extract the binary
unzip terraform.zip

# Make it executable
chmod +x terraform

# Test locally
./terraform version

# Optional: Move to system PATH
sudo mv terraform /usr/local/bin/
```

## Method 3: Install Homebrew first (if not available)

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then follow Method 1
```

## Verification

After installation, verify with:
```bash
terraform version
terraform -help
```

## Note for this Lab

In our test, we used Method 2 (manual installation) and ran Terraform locally with `./terraform` since we're in a controlled lab environment.
