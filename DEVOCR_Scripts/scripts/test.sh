#!/bin/bash

# Test Script for Flask Docker Application
# This script tests if the application is working correctly

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[TEST]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Test if Docker is available
print_status "Checking Docker availability..."
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed or not in PATH"
    exit 1
fi

# Test if the image exists
print_status "Checking if example-app image exists..."
if ! sudo docker image ls | grep -q example-app; then
    print_warning "example-app image not found. Building it now..."
    cd docker_app
    sudo docker build -t example-app .
    cd ..
fi

# Test if container is running
print_status "Checking if container is running..."
CONTAINER_ID=$(sudo docker ps -q --filter ancestor=example-app | head -1)

if [ -z "$CONTAINER_ID" ]; then
    print_warning "No running container found. Starting one..."
    CONTAINER_ID=$(sudo docker run -dit -p 5000:5000 example-app)
    print_status "Started container: $CONTAINER_ID"
    sleep 3  # Give it time to start
fi

# Test HTTP response
print_status "Testing HTTP response..."
for i in {1..5}; do
    if curl -s http://localhost:5000 > /dev/null; then
        RESPONSE=$(curl -s http://localhost:5000)
        print_status "Application is responding!"
        print_status "Response: $RESPONSE"
        
        # Check if response contains expected content
        if echo "$RESPONSE" | grep -q "Cisco DevNet"; then
            print_status "✅ Application test PASSED!"
            break
        else
            print_warning "Response doesn't contain expected content"
        fi
    else
        print_warning "Attempt $i: Application not responding, waiting..."
        sleep 2
    fi
    
    if [ $i -eq 5 ]; then
        print_error "❌ Application test FAILED after 5 attempts"
        print_status "Container logs:"
        sudo docker logs $CONTAINER_ID
        exit 1
    fi
done

# Show container info
print_status "Container information:"
echo "Container ID: $CONTAINER_ID"
echo "Port mapping: $(sudo docker port $CONTAINER_ID)"
echo "Status: $(sudo docker ps --filter id=$CONTAINER_ID --format 'table {{.Status}}')"

print_status "🎉 All tests completed successfully!"
print_status "Application is available at: http://localhost:5000"
