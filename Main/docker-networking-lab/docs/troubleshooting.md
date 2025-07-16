# Troubleshooting Guide

## Common Issues and Solutions

### 1. Network Creation Issues

#### Error: "network with name already exists"
```bash
# Solution: Remove existing network first
docker network rm labnet
docker network create labnet
```

#### Error: "could not find an available, non-overlapping IPv4 address pool"
```bash
# Solution: Specify custom subnet
docker network create --subnet=172.20.0.0/16 labnet
```

### 2. Container Startup Issues

#### Error: "port is already allocated"
```bash
# Check what's using the port
sudo lsof -i :80
# or
netstat -tulpn | grep :80

# Solution: Use different port or stop conflicting service
docker run -p 8080:80 nginx
```

#### Error: "no such network"
```bash
# Verify network exists
docker network ls

# Create network if missing
docker network create labnet
```

### 3. Connectivity Issues

#### Cannot ping between containers
**Symptoms:** `ping: bad address 'webserver'`

**Diagnosis:**
```bash
# Check if containers are on same network
docker inspect webserver | grep NetworkMode
docker inspect client | grep NetworkMode

# Check network membership
docker network inspect labnet
```

**Solutions:**
1. Ensure both containers are on the same user-defined network
2. Restart containers if needed
3. Use container IP directly as temporary workaround

#### DNS resolution not working
**Symptoms:** `nslookup: can't resolve 'webserver'`

**Solutions:**
1. Ensure using user-defined network (not default bridge)
2. Check container names are correct and containers are running
3. Try using IP address directly

#### HTTP requests fail
**Symptoms:** `curl: (7) Failed to connect`

**Diagnosis:**
```bash
# Check if NGINX is running
docker logs webserver

# Check if port 80 is open
docker exec client nc -z webserver 80

# Check NGINX status inside container
docker exec webserver nginx -t
```

**Solutions:**
1. Verify NGINX container is running and healthy
2. Check firewall rules
3. Try accessing with IP address

### 4. Permission Issues

#### Docker commands require sudo
**Solution:**
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Logout and login again, or run:
newgrp docker
```

#### Cannot access Docker daemon
**Error:** `Cannot connect to the Docker daemon`

**Solutions:**
1. Start Docker service:
   ```bash
   # On systemd systems
   sudo systemctl start docker
   
   # On macOS
   open /Applications/Docker.app
   ```

2. Check Docker daemon status:
   ```bash
   sudo systemctl status docker
   ```

### 5. Resource Issues

#### Out of disk space
**Error:** `no space left on device`

**Solutions:**
```bash
# Clean up unused containers
docker container prune

# Clean up unused images
docker image prune

# Clean up unused networks
docker network prune

# Clean up everything
docker system prune -a
```

#### Memory issues
**Symptoms:** Containers getting killed, poor performance

**Solutions:**
1. Check available memory: `free -h`
2. Increase Docker memory limit (Docker Desktop)
3. Use lighter base images (alpine instead of ubuntu)

### 6. Platform-Specific Issues

#### macOS Issues
1. **File sharing**: Ensure project directory is in Docker's file sharing list
2. **Performance**: Use Docker Desktop with proper resource allocation
3. **Networking**: Docker Desktop uses hypervisor, some commands may behave differently

#### Windows Issues
1. **Line endings**: Use LF instead of CRLF for shell scripts
2. **File paths**: Use Unix-style paths in containers
3. **WSL2**: Ensure WSL2 backend is enabled for better performance

#### Linux Issues
1. **SELinux**: May block container operations, check with `getenforce`
2. **Firewall**: iptables rules may interfere with Docker networking
3. **AppArmor**: May restrict container capabilities

### 7. Script Execution Issues

#### Permission denied on scripts
```bash
# Make scripts executable
chmod +x scripts/*.sh

# Or run with bash explicitly
bash scripts/run-lab.sh
```

#### Script not found
```bash
# Ensure you're in the correct directory
cd docker-networking-lab

# Use relative paths
./scripts/run-lab.sh
```

### 8. Debugging Tools and Commands

#### Network debugging
```bash
# Check container networking details
docker inspect CONTAINER --format='{{json .NetworkSettings}}'

# Test connectivity from host
telnet CONTAINER_IP 80

# Monitor network traffic
docker exec CONTAINER tcpdump -i eth0 host webserver
```

#### Container debugging
```bash
# Get shell access to container
docker exec -it CONTAINER sh

# Check container logs
docker logs CONTAINER

# Check container processes
docker exec CONTAINER ps aux

# Check container environment
docker exec CONTAINER env
```

#### System debugging
```bash
# Check Docker system info
docker system info

# Check Docker events
docker events

# Check resource usage
docker stats
```

## Getting Help

### Documentation
- [Docker Networking Documentation](https://docs.docker.com/network/)
- [Docker CLI Reference](https://docs.docker.com/engine/reference/commandline/)

### Community Resources
- [Docker Community Forums](https://forums.docker.com/)
- [Docker Subreddit](https://reddit.com/r/docker)
- [Stack Overflow Docker Tag](https://stackoverflow.com/questions/tagged/docker)

### Professional Support
- [Docker Support](https://www.docker.com/support)
- [Docker Enterprise](https://www.docker.com/products/docker-enterprise)

## Reporting Issues

When reporting issues, include:

1. Docker version: `docker version`
2. System information: `docker system info`
3. Operating system and version
4. Exact error messages
5. Steps to reproduce
6. Expected vs actual behavior

```bash
# Collect debug information
echo "=== Docker Version ===" > debug-info.txt
docker version >> debug-info.txt
echo "=== System Info ===" >> debug-info.txt
docker system info >> debug-info.txt
echo "=== Networks ===" >> debug-info.txt
docker network ls >> debug-info.txt
echo "=== Containers ===" >> debug-info.txt
docker ps -a >> debug-info.txt
```
