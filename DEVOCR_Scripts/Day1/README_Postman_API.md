# Postman API Scripts

This directory contains Python scripts for interacting with the Postman API, similar to the Webex API script structure.

## Files

1. **postman_interaction.py** - Basic Postman API script for creating collections
2. **postman_api_advanced.py** - Advanced script with class-based approach and multiple API operations

## Prerequisites

1. **Postman API Key**: You need to obtain an API key from Postman
   - Go to https://web.postman.co/settings/me/api-keys
   - Generate a new API key
   - Replace `YOUR_POSTMAN_API_KEY_HERE` in the scripts with your actual API key

2. **Python Dependencies**: Install required packages
   ```bash
   pip install requests urllib3
   ```

## Usage

### Basic Script (postman_interaction.py)

This script demonstrates:
- Creating a new collection
- Retrieving all collections

```bash
python postman_interaction.py
```

### Advanced Script (postman_api_advanced.py)

This script demonstrates:
- Creating workspaces
- Managing environments
- Creating collections
- Retrieving various resources

```bash
python postman_api_advanced.py
```

## Postman API Endpoints Used

- **Collections**: `https://api.getpostman.com/collections`
- **Workspaces**: `https://api.getpostman.com/workspaces`
- **Environments**: `https://api.getpostman.com/environments`

## API Key Security

⚠️ **Important**: Never commit your actual API key to version control. Consider using:
- Environment variables: `os.getenv('POSTMAN_API_KEY')`
- Configuration files (added to .gitignore)
- Secret management tools

## Example Environment Variable Usage

```python
import os
POSTMAN_API_KEY = os.getenv('POSTMAN_API_KEY', 'your_default_key_here')
```

Set the environment variable:
```bash
export POSTMAN_API_KEY="your_actual_api_key_here"
```

## API Documentation

For more information about the Postman API, visit:
https://documenter.getpostman.com/view/631643/JsLs/?version=latest
