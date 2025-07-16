#!/bin/bash

echo "🚀 Starting Docker Networking Lab - Automated Execution"
echo "======================================================"
echo ""

# Change to script directory
cd "$(dirname "$0")"

# Step 1: Create network
echo "Phase 1: Network Creation"
echo "-------------------------"
./create-network.sh
if [ $? -ne 0 ]; then
    echo "❌ Failed at network creation step"
    exit 1
fi

echo ""
sleep 2

# Step 2: Start web server
echo "Phase 2: Web Server Deployment"
echo "------------------------------"
./start-webserver.sh
if [ $? -ne 0 ]; then
    echo "❌ Failed at web server deployment step"
    ./cleanup.sh
    exit 1
fi

echo ""
sleep 2

# Step 3: Start client container (non-interactive for automated testing)
echo "Phase 3: Client Container Deployment"
echo "------------------------------------"
echo "🚀 Starting client container..."
docker rm -f client 2>/dev/null || true
docker run -d --name client --network labnet alpine sleep 300

if [ $? -eq 0 ]; then
    echo "✅ Client container started successfully!"
else
    echo "❌ Failed to start client container"
    ./cleanup.sh
    exit 1
fi

echo ""
sleep 2

# Step 4: Run connectivity tests
echo "Phase 4: Connectivity Testing"
echo "-----------------------------"
./test-connectivity.sh
if [ $? -ne 0 ]; then
    echo "❌ Connectivity tests failed"
    ./cleanup.sh
    exit 1
fi

echo ""
echo "🎉 Lab completed successfully!"
echo ""
echo "🔧 Manual testing options:"
echo "  - Run './start-client.sh' for interactive testing"
echo "  - Access NGINX at http://localhost:8080 (if port is mapped)"
echo "  - Run 'docker logs webserver' to see web server logs"
echo ""
echo "🧹 To clean up:"
echo "  - Run './cleanup.sh'"
echo ""

# Ask user if they want to clean up immediately
read -p "Do you want to clean up now? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./cleanup.sh
else
    echo "Resources left running for manual exploration."
    echo "Remember to run './cleanup.sh' when done!"
fi
