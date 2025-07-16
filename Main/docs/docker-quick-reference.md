# Docker Quick Reference

## Essential Docker Commands

### Image Management
```bash
# Build an image
docker build -t <image-name> .

# List images
docker image ls

# Remove an image
docker rmi <image-name>

# Pull an image from Docker Hub
docker pull <image-name>
```

### Container Management
```bash
# Run a container
docker run -d -p <host-port>:<container-port> <image-name>

# List running containers
docker ps

# List all containers
docker ps -a

# Stop a container
docker stop <container-id>

# Start a stopped container
docker start <container-id>

# Remove a container
docker rm <container-id>

# Execute command in running container
docker exec -it <container-id> <command>
```

### Common Flags
- `-d` : Run in detached mode (background)
- `-i` : Interactive mode
- `-t` : Allocate a pseudo-TTY
- `-p` : Port mapping (host:container)
- `-v` : Volume mounting
- `-e` : Set environment variables
- `--name` : Assign a name to container

### Debugging
```bash
# View container logs
docker logs <container-id>

# Follow logs in real-time
docker logs -f <container-id>

# Inspect container details
docker inspect <container-id>

# View container resource usage
docker stats <container-id>
```

### Cleanup
```bash
# Remove all stopped containers
docker container prune

# Remove all unused images
docker image prune

# Remove all unused volumes
docker volume prune

# Remove all unused networks
docker network prune

# Remove everything unused
docker system prune
```

## Dockerfile Best Practices

1. **Use specific base image versions**
   ```dockerfile
   FROM python:3.8-slim
   ```

2. **Minimize layers**
   ```dockerfile
   RUN apt-get update && apt-get install -y \
       package1 \
       package2 \
       && rm -rf /var/lib/apt/lists/*
   ```

3. **Use .dockerignore**
   ```
   .git
   .gitignore
   README.md
   Dockerfile
   .dockerignore
   ```

4. **Set working directory**
   ```dockerfile
   WORKDIR /app
   ```

5. **Copy requirements first for better caching**
   ```dockerfile
   COPY requirements.txt .
   RUN pip install -r requirements.txt
   COPY . .
   ```
