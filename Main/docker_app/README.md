# Docker Flask Application

This directory contains a Flask web application that can be deployed using Docker.

## Quick Start

1. **Load environment variables**:
   ```bash
   source .envrc
   ```

2. **Install dependencies locally** (optional):
   ```bash
   pip install -r requirements.txt
   ```

3. **Run locally** (optional):
   ```bash
   python program.py
   ```

4. **Build Docker image**:
   ```bash
   sudo docker build -t example-app .
   ```

5. **Run with Docker**:
   ```bash
   sudo docker run -dit -p 5000:5000 example-app
   ```

6. **Test the application**:
   Open http://localhost:5000 in your browser

## Files Description

- `.envrc` - Environment variables configuration
- `program.py` - Main Flask application
- `requirements.txt` - Python dependencies
- `Dockerfile` - Docker image configuration
- `README.md` - This file

## Application Details

The application displays a welcome message using the course name from environment variables. It runs on port 5000 and is accessible via web browser.

For detailed deployment instructions, see the main `APPLICATION_DEPLOYMENT_GUIDE.md` in the parent directory.
