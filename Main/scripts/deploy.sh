#!/bin/bash

# Docker Application Deployment Script
# This script automates the deployment process

set -e  # Exit on any error

echo "🚀 Starting Docker Application Deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

# Navigate to the docker_app directory
if [ ! -d "docker_app" ]; then
    print_error "docker_app directory not found. Please ensure you're in the correct directory."
    exit 1
fi

cd docker_app

print_status "Building Docker image..."
if sudo docker build -t example-app .; then
    print_status "Docker image built successfully!"
else
    print_error "Failed to build Docker image."
    exit 1
fi

print_status "Checking if image exists..."
sudo docker image ls | grep example-app

print_status "Starting container..."
CONTAINER_ID=$(sudo docker run -dit -p 5000:5000 example-app)

if [ $? -eq 0 ]; then
    print_status "Container started successfully!"
    print_status "Container ID: $CONTAINER_ID"
    print_status "Application is available at: http://localhost:5000"
    print_warning "To stop the container, run: sudo docker stop $CONTAINER_ID"
else
    print_error "Failed to start container."
    exit 1
fi

echo "✅ Deployment completed successfully!"
