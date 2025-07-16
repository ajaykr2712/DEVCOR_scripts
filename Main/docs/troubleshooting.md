# Troubleshooting Guide

## Common Issues and Solutions

### 1. Permission Denied Errors

**Problem**: Getting permission denied when running Docker commands.

**Solutions**:
- Add your user to the docker group:
  ```bash
  sudo usermod -aG docker $USER
  newgrp docker
  ```
- Or use `sudo` with Docker commands
- On macOS, ensure Docker Desktop is running

### 2. Port Already in Use

**Problem**: Error "port is already allocated" or "address already in use".

**Solutions**:
- Check what's using the port:
  ```bash
  lsof -i :5000
  ```
- Use a different port:
  ```bash
  docker run -p 8080:5000 example-app
  ```
- Stop the conflicting process

### 3. Image Build Failures

**Problem**: Docker build command fails.

**Common Causes and Solutions**:

- **Missing requirements.txt**:
  ```
  ERROR: Could not open requirements file
  ```
  Solution: Ensure `requirements.txt` exists in the build context

- **Python package installation fails**:
  ```
  ERROR: No matching distribution found
  ```
  Solution: Check package names and versions in `requirements.txt`

- **Network issues during build**:
  ```
  ERROR: temporary failure in name resolution
  ```
  Solution: Check internet connection and DNS settings

### 4. Container Startup Issues

**Problem**: Container exits immediately or fails to start.

**Debugging Steps**:
1. Check container logs:
   ```bash
   docker logs <container-id>
   ```

2. Run container interactively:
   ```bash
   docker run -it example-app /bin/bash
   ```

3. Check if the application file exists:
   ```bash
   docker run -it example-app ls -la
   ```

### 5. Application Not Accessible

**Problem**: Cannot access the application at localhost:5000.

**Solutions**:
- Verify container is running:
  ```bash
  docker ps
  ```
- Check port mapping:
  ```bash
  docker port <container-id>
  ```
- Ensure Flask app binds to 0.0.0.0, not 127.0.0.1
- Try accessing via container IP:
  ```bash
  docker inspect <container-id> | grep IPAddress
  ```

### 6. Environment Variable Issues

**Problem**: Environment variables not being read correctly.

**Solutions**:
- Check if variables are set in container:
  ```bash
  docker exec -it <container-id> env
  ```
- Pass variables explicitly:
  ```bash
  docker run -e COURSE="Your Course" example-app
  ```
- Use `.env` file:
  ```bash
  docker run --env-file .env example-app
  ```

### 7. Volume/File Mounting Issues

**Problem**: Files not being copied to container or changes not reflected.

**Solutions**:
- Check Dockerfile COPY instructions
- Verify file paths are correct
- Use `.dockerignore` to exclude unnecessary files
- Check file permissions

### 8. Resource Constraints

**Problem**: Container runs slowly or crashes due to resource limits.

**Solutions**:
- Increase Docker Desktop memory/CPU limits
- Monitor resource usage:
  ```bash
  docker stats
  ```
- Set resource limits explicitly:
  ```bash
  docker run --memory="512m" --cpus="1.0" example-app
  ```

## Diagnostic Commands

### Container Health Check
```bash
# Check if container is running
docker ps --filter "ancestor=example-app"

# Check container resource usage
docker stats --no-stream

# Inspect container configuration
docker inspect <container-id>
```

### Application Debugging
```bash
# Access container shell
docker exec -it <container-id> /bin/bash

# Check application logs
docker logs -f <container-id>

# Test network connectivity
docker exec -it <container-id> curl localhost:5000
```

### System Information
```bash
# Docker version and info
docker version
docker info

# Available system resources
docker system df

# Clean up unused resources
docker system prune
```

## Best Practices for Troubleshooting

1. **Always check logs first**: `docker logs <container-id>`
2. **Use specific error messages for searches**: Copy exact error text
3. **Test components individually**: Verify Python app works before containerizing
4. **Keep Docker and system updated**: Newer versions fix many issues
5. **Use minimal test cases**: Simplify until you find the root cause
6. **Document solutions**: Keep track of fixes for future reference

## Getting Help

- Docker Official Documentation: https://docs.docker.com/
- Flask Documentation: https://flask.palletsprojects.com/
- Stack Overflow: Search for specific error messages
- Docker Community Forums: https://forums.docker.com/
