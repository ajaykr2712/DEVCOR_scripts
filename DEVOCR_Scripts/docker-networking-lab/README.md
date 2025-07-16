# Docker Networking Lab

This project demonstrates Docker container networking using a user-defined bridge network. It consists of two containers:

- **Container 1**: NGINX web server
- **Container 2**: Alpine Linux client for testing connectivity

## Architecture

```
┌─────────────────────────────────────────┐
│             labnet (bridge)             │
│                                         │
│  ┌─────────────┐    ┌─────────────┐    │
│  │  webserver  │    │   client    │    │
│  │   (nginx)   │◄──►│  (alpine)   │    │
│  │             │    │             │    │
│  └─────────────┘    └─────────────┘    │
└─────────────────────────────────────────┘
```

## Prerequisites

- Docker installed and running
- Basic understanding of Docker networking concepts

## Quick Start

### Option 1: Manual Execution
Run the lab step by step:
```bash
# Step 1: Create network
./scripts/create-network.sh

# Step 2: Start web server
./scripts/start-webserver.sh

# Step 3: Test connectivity (interactive)
./scripts/start-client.sh

# Step 4: Cleanup
./scripts/cleanup.sh
```

### Option 2: Automated Execution
Run the complete lab automatically:
```bash
./scripts/run-lab.sh
```

### Option 3: Docker Compose
Use Docker Compose for easy management:
```bash
docker-compose up -d
docker-compose exec client sh
# Test connectivity from inside client container
docker-compose down
```

## Project Structure

```
docker-networking-lab/
├── README.md                 # This file
├── docker-compose.yml        # Docker Compose configuration
├── Dockerfile.client         # Custom Alpine client with tools
├── scripts/
│   ├── create-network.sh     # Step 1: Create network
│   ├── start-webserver.sh    # Step 2: Start NGINX container
│   ├── start-client.sh       # Step 3: Start client container
│   ├── test-connectivity.sh  # Step 4: Automated connectivity tests
│   ├── cleanup.sh           # Step 5: Clean up resources
│   └── run-lab.sh           # Complete automated lab
├── tests/
│   └── test-lab.sh          # Automated test suite
└── docs/
    ├── networking-concepts.md
    └── troubleshooting.md
```

## Learning Objectives

After completing this lab, you will understand:

1. How to create custom Docker networks
2. Container-to-container communication using container names
3. Docker's built-in DNS resolution
4. Network isolation and connectivity testing
5. Docker networking best practices

## Next Steps

- Explore different network drivers (host, overlay, macvlan)
- Implement service discovery patterns
- Add load balancing with multiple web servers
- Integrate with Docker Swarm for multi-host networking
