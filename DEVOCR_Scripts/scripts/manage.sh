#!/bin/bash

# Docker Container Management Script
# This script helps manage Docker containers and images

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}$1${NC}"
}

# Function to show running containers
show_containers() {
    print_header "=== Running Containers ==="
    sudo docker ps
    echo ""
}

# Function to show all containers
show_all_containers() {
    print_header "=== All Containers ==="
    sudo docker ps -a
    echo ""
}

# Function to show images
show_images() {
    print_header "=== Docker Images ==="
    sudo docker image ls
    echo ""
}

# Function to stop all example-app containers
stop_app_containers() {
    print_status "Stopping all example-app containers..."
    CONTAINERS=$(sudo docker ps -q --filter ancestor=example-app)
    if [ -n "$CONTAINERS" ]; then
        sudo docker stop $CONTAINERS
        print_status "Stopped containers: $CONTAINERS"
    else
        print_warning "No running example-app containers found."
    fi
}

# Function to clean up containers and images
cleanup() {
    print_warning "This will remove ALL stopped containers and the example-app image."
    read -p "Are you sure? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Removing stopped containers..."
        sudo docker container prune -f
        
        print_status "Removing example-app image..."
        sudo docker rmi example-app 2>/dev/null || print_warning "example-app image not found."
        
        print_status "Cleanup completed!"
    else
        print_status "Cleanup cancelled."
    fi
}

# Function to show logs
show_logs() {
    CONTAINER_ID=$(sudo docker ps -q --filter ancestor=example-app | head -1)
    if [ -n "$CONTAINER_ID" ]; then
        print_status "Showing logs for container: $CONTAINER_ID"
        sudo docker logs $CONTAINER_ID
    else
        print_warning "No running example-app container found."
    fi
}

# Main menu
case "${1:-menu}" in
    "containers"|"ps")
        show_containers
        ;;
    "all")
        show_all_containers
        ;;
    "images")
        show_images
        ;;
    "stop")
        stop_app_containers
        ;;
    "logs")
        show_logs
        ;;
    "cleanup")
        cleanup
        ;;
    "status")
        show_containers
        show_images
        ;;
    "menu"|*)
        echo "Docker Container Management Script"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  containers, ps  - Show running containers"
        echo "  all            - Show all containers"
        echo "  images         - Show Docker images"
        echo "  stop           - Stop all example-app containers"
        echo "  logs           - Show logs of running container"
        echo "  cleanup        - Remove stopped containers and images"
        echo "  status         - Show containers and images"
        echo "  menu           - Show this menu (default)"
        echo ""
        ;;
esac
