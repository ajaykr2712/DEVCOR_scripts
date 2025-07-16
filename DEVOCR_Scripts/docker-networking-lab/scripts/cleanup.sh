#!/bin/bash

echo "Step 5: Cleaning up lab resources..."

# Remove containers
echo "🗑️ Removing containers..."
docker rm -f webserver client 2>/dev/null || true

# Remove network
echo "🗑️ Removing network..."
docker network rm labnet 2>/dev/null || true

# Remove any orphaned volumes
echo "🗑️ Cleaning up volumes..."
docker volume prune -f > /dev/null 2>&1

echo "✅ Cleanup completed!"
echo ""
echo "📋 Remaining networks:"
docker network ls
echo ""
echo "📋 Remaining containers:"
docker ps -a
