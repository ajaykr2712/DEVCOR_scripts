# Docker Networking Lab Makefile

.PHONY: help setup run test clean status logs shell-client shell-webserver

# Default target
help:
	@echo "Docker Networking Lab - Available Commands:"
	@echo "==========================================="
	@echo "  make setup     - Create network and start containers"
	@echo "  make run       - Run the complete automated lab"
	@echo "  make test      - Run the test suite"
	@echo "  make clean     - Clean up all resources"
	@echo "  make status    - Show current lab status"
	@echo "  make logs      - Show container logs"
	@echo "  make shell-client    - Get shell access to client container"
	@echo "  make shell-webserver - Get shell access to webserver container"
	@echo ""
	@echo "Quick Start:"
	@echo "  make run       # For automated execution"
	@echo "  make setup && make shell-client  # For manual testing"

# Set up the lab environment
setup:
	@echo "🚀 Setting up Docker Networking Lab..."
	@./scripts/create-network.sh
	@./scripts/start-webserver.sh
	@echo "🚀 Starting client container..."
	@docker rm -f client 2>/dev/null || true
	@docker run -d --name client --network labnet alpine sleep 300
	@docker exec client apk add --no-cache curl ping nmap > /dev/null 2>&1
	@echo "✅ Lab setup complete!"

# Run the complete automated lab
run:
	@./scripts/run-lab.sh

# Run test suite
test:
	@./tests/test-lab.sh

# Clean up all resources
clean:
	@./scripts/cleanup.sh

# Show current lab status
status:
	@echo "📊 Lab Status:"
	@echo "=============="
	@echo ""
	@echo "🌐 Networks:"
	@docker network ls | grep -E "(NETWORK|labnet)" || echo "No lab network found"
	@echo ""
	@echo "📦 Containers:"
	@docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "(NAMES|webserver|client)" || echo "No lab containers found"
	@echo ""
	@if docker network inspect labnet >/dev/null 2>&1; then \
		echo "🔍 Network Details:"; \
		docker network inspect labnet --format "{{.Name}}: {{.IPAM.Config}}"; \
		echo ""; \
		echo "🏠 Container IPs:"; \
		if docker ps -q --filter name=webserver | grep -q .; then \
			echo "  webserver: $$(docker inspect webserver --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')"; \
		fi; \
		if docker ps -q --filter name=client | grep -q .; then \
			echo "  client: $$(docker inspect client --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')"; \
		fi; \
	fi

# Show container logs
logs:
	@echo "📝 Container Logs:"
	@echo "=================="
	@if docker ps -q --filter name=webserver | grep -q .; then \
		echo ""; \
		echo "🌐 Webserver logs:"; \
		docker logs --tail 10 webserver; \
	fi
	@if docker ps -q --filter name=client | grep -q .; then \
		echo ""; \
		echo "🖥️  Client logs:"; \
		docker logs --tail 10 client; \
	fi

# Get shell access to client container
shell-client:
	@if docker ps -q --filter name=client | grep -q .; then \
		echo "🐚 Entering client container shell..."; \
		echo "💡 Try: ping webserver, curl webserver"; \
		docker exec -it client sh; \
	else \
		echo "❌ Client container not running. Run 'make setup' first."; \
	fi

# Get shell access to webserver container
shell-webserver:
	@if docker ps -q --filter name=webserver | grep -q .; then \
		echo "🐚 Entering webserver container shell..."; \
		docker exec -it webserver bash; \
	else \
		echo "❌ Webserver container not running. Run 'make setup' first."; \
	fi

# Docker Compose alternatives
compose-up:
	@docker-compose up -d
	@echo "✅ Lab started with Docker Compose"
	@echo "💡 Run 'make compose-shell' for interactive testing"

compose-down:
	@docker-compose down
	@echo "✅ Lab stopped with Docker Compose"

compose-shell:
	@docker-compose exec client sh
