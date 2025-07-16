#!/bin/bash

echo "🧪 Docker Networking Lab Test Suite"
echo "===================================="
echo ""

# Test configuration
TEST_NETWORK="labnet-test"
TEST_WEB="webserver-test"
TEST_CLIENT="client-test"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    echo -n "Test $TESTS_RUN: $test_name... "
    
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}PASS${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "${RED}FAIL${NC}"
        return 1
    fi
}

# Cleanup function
cleanup_test() {
    docker rm -f $TEST_WEB $TEST_CLIENT 2>/dev/null || true
    docker network rm $TEST_NETWORK 2>/dev/null || true
}

# Setup test environment
setup_test() {
    echo "Setting up test environment..."
    cleanup_test
    
    # Create test network
    docker network create $TEST_NETWORK
    
    # Start test web server
    docker run -d --name $TEST_WEB --network $TEST_NETWORK nginx
    
    # Start test client
    docker run -d --name $TEST_CLIENT --network $TEST_NETWORK alpine sleep 300
    
    # Install curl in client
    docker exec $TEST_CLIENT apk add --no-cache curl > /dev/null 2>&1
}

echo "🔧 Setting up test environment..."
setup_test

echo ""
echo "Running tests..."
echo "----------------"

# Test 1: Network creation
run_test "Network exists" "docker network ls | grep -q $TEST_NETWORK"

# Test 2: Containers running
run_test "Web server container running" "docker ps | grep -q $TEST_WEB"
run_test "Client container running" "docker ps | grep -q $TEST_CLIENT"

# Test 3: Network connectivity
run_test "Containers on same network" "docker inspect $TEST_WEB --format='{{range .NetworkSettings.Networks}}{{.NetworkID}}{{end}}' | grep -q \$(docker inspect $TEST_CLIENT --format='{{range .NetworkSettings.Networks}}{{.NetworkID}}{{end}}')"

# Test 4: DNS resolution
run_test "DNS resolution works" "docker exec $TEST_CLIENT nslookup $TEST_WEB"

# Test 5: Ping connectivity
run_test "Ping connectivity" "docker exec $TEST_CLIENT ping -c 1 $TEST_WEB"

# Test 6: HTTP connectivity
run_test "HTTP service accessible" "docker exec $TEST_CLIENT curl -s $TEST_WEB"

# Test 7: Port accessibility
run_test "Port 80 open" "docker exec $TEST_CLIENT nc -z $TEST_WEB 80"

echo ""
echo "Test Results:"
echo "============="
echo "Tests run: $TESTS_RUN"
echo -e "Tests passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests failed: ${RED}$((TESTS_RUN - TESTS_PASSED))${NC}"

if [ $TESTS_PASSED -eq $TESTS_RUN ]; then
    echo -e "${GREEN}All tests passed! ✅${NC}"
    RESULT=0
else
    echo -e "${RED}Some tests failed! ❌${NC}"
    RESULT=1
fi

echo ""
echo "🧹 Cleaning up test environment..."
cleanup_test

exit $RESULT
