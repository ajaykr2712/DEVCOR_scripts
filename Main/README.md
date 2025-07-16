# DEVOCR Scripts - Flask Docker Application Project

This repository contains a complete Flask web application with Docker deployment, created as part of the "Developing Applications using Cisco Core Platforms and APIs" course.

## 📁 Project Structure

```
DEVOCR_Scripts/
├── APPLICATION_DEPLOYMENT_GUIDE.md    # Comprehensive deployment guide
├── README.md                          # This file
├── docker_app/                       # Main application directory
│   ├── .envrc                        # Environment variables
│   ├── program.py                    # Flask application
│   ├── requirements.txt              # Python dependencies
│   ├── Dockerfile                    # Docker configuration
│   └── README.md                     # App-specific documentation
├── scripts/                          # Automation scripts
│   ├── deploy.sh                     # Automated deployment script
│   └── manage.sh                     # Container management script
├── docs/                             # Additional documentation
│   ├── docker-quick-reference.md     # Docker command reference
│   └── troubleshooting.md           # Common issues and solutions
└── [legacy files]                   # Original API interaction scripts
```

## 🚀 Quick Start

### Option 1: Automated Deployment
```bash
# Run the automated deployment script
./scripts/deploy.sh
```

### Option 2: Manual Deployment
```bash
# Navigate to the application directory
cd docker_app

# Load environment variables
source .envrc

# Build and run with Docker
sudo docker build -t example-app .
sudo docker run -dit -p 5000:5000 example-app

# Test the application
open http://localhost:5000
```

## 📖 Documentation

- **[APPLICATION_DEPLOYMENT_GUIDE.md](APPLICATION_DEPLOYMENT_GUIDE.md)** - Complete step-by-step deployment guide
- **[docs/docker-quick-reference.md](docs/docker-quick-reference.md)** - Docker commands and best practices
- **[docs/troubleshooting.md](docs/troubleshooting.md)** - Common issues and solutions
- **[docker_app/README.md](docker_app/README.md)** - Application-specific documentation

## 🛠️ Available Scripts

### Deployment Script (`scripts/deploy.sh`)
Automates the entire deployment process:
- Builds Docker image
- Starts container
- Provides status updates
- Shows container ID for management

### Management Script (`scripts/manage.sh`)
Provides container management functionality:
```bash
./scripts/manage.sh containers    # Show running containers
./scripts/manage.sh stop         # Stop application containers
./scripts/manage.sh logs         # Show container logs
./scripts/manage.sh cleanup      # Clean up containers and images
./scripts/manage.sh status       # Show complete status
```

## 🔧 Requirements

- **Docker Desktop** - For containerization
- **Python 3.8+** - For local development (optional)
- **Bash** - For running automation scripts

## 🌐 Application Details

The Flask application:
- Displays a welcome message with course information
- Runs on port 5000
- Uses environment variables for configuration
- Dockerized for easy deployment and scaling

## 📝 Original Files

This project also contains the original training files:
- `postman_api_advanced.py` - Advanced Postman API interactions
- `postman_interaction.py` - Basic Postman API examples
- `webex_interaction.py` - Webex API integration
- `README_Postman_API.md` - Postman API documentation
- `doc.md` - Original deployment steps (converted to this project)

## 🎯 Learning Objectives

This project demonstrates:
- Flask web application development
- Docker containerization
- Environment variable management
- Automated deployment scripts
- Container lifecycle management
- Documentation best practices

## 🔍 Troubleshooting

If you encounter issues:
1. Check the [troubleshooting guide](docs/troubleshooting.md)
2. Verify Docker is running: `docker --version`
3. Check container status: `./scripts/manage.sh status`
4. View logs: `./scripts/manage.sh logs`

## 📚 Additional Resources

- [Docker Official Documentation](https://docs.docker.com/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [Python Environment Variables](https://docs.python.org/3/library/os.html#os.environ)

## 🤝 Contributing

This is a training project, but improvements are welcome:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📧 Support

For questions related to the course content, please contact your trainer or refer to the course materials.

---

**Course**: Developing Applications using Cisco Core Platforms and APIs  
**Created**: July 16, 2025  
**Last Updated**: July 16, 2025
