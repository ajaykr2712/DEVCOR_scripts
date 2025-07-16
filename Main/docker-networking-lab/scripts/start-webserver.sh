#!/bin/bash

echo "Step 2: Starting NGINX web server container..."

# Stop and remove existing webserver container if it exists
docker rm -f webserver 2>/dev/null || true

# Start the NGINX container
docker run -d --name webserver --network labnet nginx

if [ $? -eq 0 ]; then
    echo "✅ Web server container 'webserver' started successfully!"
    echo ""
    echo "📋 Container status:"
    docker ps --filter name=webserver
    echo ""
    echo "🔍 Container details:"
    docker inspect webserver --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
    echo "📍 Web server IP address: $(docker inspect webserver --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')"
else
    echo "❌ Failed to start web server container"
    exit 1
fi
