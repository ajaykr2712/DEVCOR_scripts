#!/bin/bash

echo "🧪 Running automated connectivity tests..."
echo ""

# Function to run command in client container
run_in_client() {
    docker exec client $@
}

# Test 1: Basic ping test
echo "1️⃣ Testing ping connectivity..."
if run_in_client ping -c 3 webserver > /dev/null 2>&1; then
    echo "✅ Ping test passed"
else
    echo "❌ Ping test failed"
    exit 1
fi

# Test 2: DNS resolution
echo "2️⃣ Testing DNS resolution..."
if run_in_client nslookup webserver > /dev/null 2>&1; then
    echo "✅ DNS resolution test passed"
else
    echo "❌ DNS resolution test failed"
fi

# Test 3: HTTP connectivity
echo "3️⃣ Testing HTTP connectivity..."
run_in_client apk add --no-cache curl > /dev/null 2>&1
if run_in_client curl -s webserver > /dev/null 2>&1; then
    echo "✅ HTTP connectivity test passed"
else
    echo "❌ HTTP connectivity test failed"
    exit 1
fi

# Test 4: Port scan
echo "4️⃣ Testing port accessibility..."
run_in_client apk add --no-cache nmap > /dev/null 2>&1
if run_in_client nmap -p 80 webserver | grep -q "80/tcp open"; then
    echo "✅ Port 80 is accessible"
else
    echo "❌ Port 80 is not accessible"
fi

echo ""
echo "🎉 All connectivity tests completed!"
echo ""
echo "📊 Network information:"
echo "Webserver IP: $(docker inspect webserver --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')"
echo "Client IP: $(docker inspect client --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')"
