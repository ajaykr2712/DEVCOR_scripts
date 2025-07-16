#!/bin/bash

echo "Step 3: Starting Alpine client container for interactive testing..."
echo ""
echo "🚀 You will be dropped into an Alpine Linux shell."
echo "🔧 Available commands for testing:"
echo "   - ping webserver"
echo "   - curl webserver"
echo "   - test-connectivity (custom script)"
echo "   - nmap webserver"
echo "   - drill webserver"
echo ""
echo "💡 Type 'exit' when you're done testing."
echo ""

# Stop and remove existing client container if it exists
docker rm -f client 2>/dev/null || true

# Start the client container interactively
docker run -it --name client --network labnet alpine sh
