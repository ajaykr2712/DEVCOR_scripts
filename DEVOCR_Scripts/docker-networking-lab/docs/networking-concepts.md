# Docker Networking Concepts

## Overview

This document explains the key networking concepts demonstrated in the Docker Networking Lab.

## Docker Network Types

### 1. Bridge Network (Default)
- Default network type for containers
- Provides isolated network namespace
- Containers can communicate with each other
- NAT is used for external connectivity

### 2. User-Defined Bridge Network
- Provides better isolation than default bridge
- Automatic DNS resolution between containers
- Can be customized (subnet, gateway, etc.)
- Recommended for production applications

### 3. Host Network
- Container shares host's network stack
- No network isolation
- Better performance but less security

### 4. Overlay Network
- For multi-host container communication
- Used in Docker Swarm and Kubernetes
- Enables container communication across different hosts

## Key Concepts Demonstrated

### Container Name Resolution
When containers are on the same user-defined network, Docker provides automatic DNS resolution:

```bash
# Container 'client' can reach 'webserver' by name
ping webserver
curl webserver
```

### Network Isolation
- Containers on different networks cannot communicate directly
- User-defined networks provide better isolation than default bridge
- Each network has its own subnet and IP range

### Service Discovery
Docker's built-in DNS server resolves container names to IP addresses:

```bash
# Docker DNS resolves 'webserver' to its container IP
nslookup webserver
# Returns: webserver has address 172.18.0.2
```

## Networking Commands

### Network Management
```bash
# List networks
docker network ls

# Create network
docker network create [OPTIONS] NETWORK

# Remove network
docker network rm NETWORK

# Inspect network
docker network inspect NETWORK
```

### Container Network Operations
```bash
# Run container on specific network
docker run --network NETWORK image

# Connect running container to network
docker network connect NETWORK CONTAINER

# Disconnect container from network
docker network disconnect NETWORK CONTAINER
```

## Network Drivers

### Bridge Driver
- Default driver for standalone containers
- Creates isolated network on host
- Supports port mapping

### Host Driver
- Removes network isolation
- Container uses host network directly
- No port mapping needed

### None Driver
- Completely disables networking
- Container has no network access
- Useful for batch jobs or security-sensitive applications

## Security Considerations

### Network Segmentation
- Use separate networks for different application tiers
- Database containers should not be on same network as web-facing containers
- Implement least privilege networking

### Port Exposure
```bash
# Only expose necessary ports
docker run -p 80:80 nginx  # Expose port 80

# Bind to specific interface
docker run -p 127.0.0.1:80:80 nginx  # Only localhost
```

### Firewall Integration
- Docker manipulates iptables rules
- Consider Docker's interaction with host firewall
- Use Docker's built-in security features

## Best Practices

### 1. Use User-Defined Networks
```bash
# ✅ Good: Use custom network
docker network create app-network
docker run --network app-network app

# ❌ Avoid: Default bridge network
docker run app
```

### 2. Network Naming
```bash
# ✅ Good: Descriptive names
docker network create frontend-network
docker network create backend-network

# ❌ Avoid: Generic names
docker network create network1
```

### 3. Container Communication
```bash
# ✅ Good: Use container names
curl webserver

# ❌ Avoid: Hard-coding IP addresses
curl 172.18.0.2
```

### 4. Port Management
```bash
# ✅ Good: Explicit port mapping
docker run -p 8080:80 nginx

# ✅ Good: Environment-specific ports
docker run -p ${PORT}:80 nginx
```

## Troubleshooting

### Common Issues

1. **Container cannot reach another container**
   - Check if both containers are on same network
   - Verify container names and DNS resolution
   - Check firewall rules

2. **Port binding fails**
   - Check if port is already in use
   - Verify port mapping syntax
   - Check host firewall settings

3. **DNS resolution not working**
   - Ensure using user-defined network (not default bridge)
   - Verify container names are correct
   - Check network configuration

### Debugging Commands
```bash
# Check container network settings
docker inspect CONTAINER

# Test connectivity from within container
docker exec CONTAINER ping TARGET

# Check network configuration
docker network inspect NETWORK

# Monitor network traffic
docker exec CONTAINER tcpdump -i eth0
```
