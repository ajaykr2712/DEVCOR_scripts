#!/bin/bash

echo "Step 1: Creating Docker network 'labnet'..."

# Check if network already exists
if docker network ls | grep -q "labnet"; then
    echo "Network 'labnet' already exists. Removing it first..."
    docker network rm labnet 2>/dev/null || true
fi

# Create the network
docker network create labnet

if [ $? -eq 0 ]; then
    echo "✅ Network 'labnet' created successfully!"
    echo ""
    echo "📋 Current networks:"
    docker network ls
else
    echo "❌ Failed to create network 'labnet'"
    exit 1
fi

echo ""
echo "🔍 Network details:"
docker network inspect labnet
