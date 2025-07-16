# Flask Application Deployment Guide with Docker

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Development Setup](#development-setup)
- [Local Development](#local-development)
- [Docker Deployment](#docker-deployment)
- [Testing](#testing)
- [Container Management](#container-management)
- [Troubleshooting](#troubleshooting)

## Overview

This guide walks you through deploying a Flask web application using Docker containerization. The application is part of the "Developing Applications using Cisco Core Platforms and APIs" course and demonstrates basic Flask development and Docker deployment practices.

## Prerequisites

Before starting, ensure you have the following installed:
- Python 3.8 or higher
- Docker Desktop
- pip (Python package installer)
- A text editor or IDE

## Project Structure

```
docker_app/
├── .envrc                 # Environment variables file
├── program.py            # Main Flask application
├── requirements.txt      # Python dependencies
├── Dockerfile           # Docker image configuration
└── README.md           # Project-specific documentation
```

## Development Setup

### Step 1: Create Project Directory

Create a new directory for your application:

```bash
mkdir docker_app
cd docker_app
```

### Step 2: Set Up Environment Variables

Create a `.envrc` file to define environment variables:

```bash
# .envrc
export COURSE="Developing Applications using Cisco Core Platforms and APIs"
```

> **Note**: To load these variables in your shell, you can use `source .envrc` or install `direnv` for automatic loading.

## Local Development

### Step 3: Create the Flask Application

Create `program.py` with the following content:

```python
from flask import Flask
import os

# Instantiate an application
app = Flask(__name__)

@app.route("/")
def home():
    course = os.environ.get('COURSE', 'Default Course')
    return f"Welcome to Cisco DevNet {course}!"

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
```

### Step 4: Install Dependencies

Install Flask using pip:

```bash
pip install flask
```

### Step 5: Run the Application Locally

Start the Flask development server:

```bash
python program.py
```

### Step 6: Test Local Deployment

Open your browser and navigate to `http://localhost:5000` to verify the application is running correctly.

## Docker Deployment

### Step 7: Create Requirements File

Create `requirements.txt` to specify Python dependencies:

```txt
flask==3.0.0
```

### Step 8: Create Dockerfile

Create a `Dockerfile` to define the container image:

```dockerfile
# Flask app example definition
FROM python:3.8

# Set environment variable
ENV COURSE=DEVCORE

# Copy application files
COPY . /app
WORKDIR /app

# Install dependencies
RUN pip install -r requirements.txt

# Expose port
EXPOSE 5000

# Define entry point
ENTRYPOINT ["python3"]
CMD ["program.py"]
```

### Step 9: Build Docker Image

Build the Docker image:

```bash
sudo docker build -t example-app .
```

### Step 10: Verify Image Creation

Check if the image was created successfully:

```bash
sudo docker image ls
```

You should see `example-app` in the list of images.

### Step 11: Run the Container

Start a container from the image:

```bash
sudo docker run -dit -p 5000:5000 example-app
```

**Command explanation:**
- `-d`: Run in detached mode (background)
- `-i`: Keep STDIN open
- `-t`: Allocate a pseudo-TTY
- `-p 5000:5000`: Map host port 5000 to container port 5000

## Testing

### Step 12: Test Containerized Application

Open your browser and navigate to `http://localhost:5000` to verify the containerized application is running correctly.

## Container Management

### Step 13: Stop the Container

To stop the running container:

1. First, find the container ID:
   ```bash
   sudo docker ps
   ```

2. Stop the container using its ID:
   ```bash
   sudo docker stop <container_id>
   ```

### Additional Container Commands

- **View running containers**: `sudo docker ps`
- **View all containers**: `sudo docker ps -a`
- **Remove a container**: `sudo docker rm <container_id>`
- **Remove an image**: `sudo docker rmi example-app`
- **View container logs**: `sudo docker logs <container_id>`

## Troubleshooting

### Common Issues

1. **Port already in use**: If port 5000 is busy, use a different port:
   ```bash
   sudo docker run -dit -p 8080:5000 example-app
   ```

2. **Permission denied**: On some systems, you might not need `sudo`:
   ```bash
   docker build -t example-app .
   docker run -dit -p 5000:5000 example-app
   ```

3. **Environment variables not loading**: Ensure `.envrc` is sourced or use Docker environment variables:
   ```bash
   sudo docker run -dit -p 5000:5000 -e COURSE="Your Course Name" example-app
   ```

### Best Practices

- Use specific version tags for dependencies
- Implement health checks in your Dockerfile
- Use multi-stage builds for production
- Set up proper logging
- Use `.dockerignore` to exclude unnecessary files

## Next Steps

- Implement CI/CD pipeline
- Add database connectivity
- Set up monitoring and logging
- Deploy to cloud platforms (AWS, Azure, GCP)
- Implement container orchestration with Kubernetes

---

**Course**: Developing Applications using Cisco Core Platforms and APIs  
**Last Updated**: July 16, 2025
