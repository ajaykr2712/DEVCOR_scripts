# Import the libraries to execute API calls for Postman API
import requests
from urllib3 import disable_warnings

# Disable Warnings
disable_warnings()

# Postman API Configuration
POSTMAN_API_KEY = "YOUR_POSTMAN_API_KEY_HERE"
BASE_URL = "https://api.getpostman.com"

# Common headers for all requests
headers = {
    "X-API-Key": POSTMAN_API_KEY,
    "Content-Type": "application/json",
}

class PostmanAPI:
    """A class to interact with Postman API"""
    
    def __init__(self, api_key):
        self.api_key = api_key
        self.headers = {
            "X-API-Key": api_key,
            "Content-Type": "application/json",
        }
        self.base_url = "https://api.getpostman.com"
    
    def create_workspace(self, name, description="", type="personal"):
        """Create a new workspace"""
        url = f"{self.base_url}/workspaces"
        payload = {
            "workspace": {
                "name": name,
                "type": type,
                "description": description
            }
        }
        
        response = requests.post(url=url, headers=self.headers, json=payload, verify=False)
        return response
    
    def get_workspaces(self):
        """Get all workspaces"""
        url = f"{self.base_url}/workspaces"
        response = requests.get(url=url, headers=self.headers, verify=False)
        return response
    
    def create_environment(self, name, values=None):
        """Create a new environment"""
        url = f"{self.base_url}/environments"
        
        if values is None:
            values = []
        
        payload = {
            "environment": {
                "name": name,
                "values": values
            }
        }
        
        response = requests.post(url=url, headers=self.headers, json=payload, verify=False)
        return response
    
    def get_environments(self):
        """Get all environments"""
        url = f"{self.base_url}/environments"
        response = requests.get(url=url, headers=self.headers, verify=False)
        return response
    
    def create_collection(self, name, description=""):
        """Create a new collection"""
        url = f"{self.base_url}/collections"
        payload = {
            "collection": {
                "info": {
                    "name": name,
                    "description": description,
                    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
                }
            }
        }
        
        response = requests.post(url=url, headers=self.headers, json=payload, verify=False)
        return response
    
    def get_collections(self):
        """Get all collections"""
        url = f"{self.base_url}/collections"
        response = requests.get(url=url, headers=self.headers, verify=False)
        return response

def main():
    """Main function to demonstrate Postman API usage"""
    
    # Initialize Postman API client
    postman = PostmanAPI(POSTMAN_API_KEY)
    
    print("=== Postman API Interaction Demo ===\n")
    
    # 1. Create a new workspace
    print("1. Creating a new workspace...")
    workspace_response = postman.create_workspace(
        name="DevOCR Training Workspace",
        description="Workspace created for DevOCR training purposes",
        type="personal"
    )
    print(f"Status Code: {workspace_response.status_code}")
    if workspace_response.status_code == 200:
        print(f"Workspace created: {workspace_response.json()}")
    else:
        print(f"Error: {workspace_response.text}")
    
    print("\n" + "="*50 + "\n")
    
    # 2. Get all workspaces
    print("2. Getting all workspaces...")
    workspaces_response = postman.get_workspaces()
    print(f"Status Code: {workspaces_response.status_code}")
    if workspaces_response.status_code == 200:
        workspaces = workspaces_response.json()
        print(f"Found {len(workspaces.get('workspaces', []))} workspaces")
        for workspace in workspaces.get('workspaces', []):
            print(f"  - {workspace.get('name')} ({workspace.get('id')})")
    
    print("\n" + "="*50 + "\n")
    
    # 3. Create a new environment
    print("3. Creating a new environment...")
    env_values = [
        {
            "key": "base_url",
            "value": "https://api.example.com",
            "enabled": True
        },
        {
            "key": "api_key",
            "value": "your_api_key_here",
            "enabled": True
        }
    ]
    
    env_response = postman.create_environment(
        name="DevOCR Training Environment",
        values=env_values
    )
    print(f"Status Code: {env_response.status_code}")
    if env_response.status_code == 200:
        print(f"Environment created: {env_response.json()}")
    else:
        print(f"Error: {env_response.text}")
    
    print("\n" + "="*50 + "\n")
    
    # 4. Create a new collection
    print("4. Creating a new collection...")
    collection_response = postman.create_collection(
        name="DevOCR Training Collection",
        description="Collection for API testing and training"
    )
    print(f"Status Code: {collection_response.status_code}")
    if collection_response.status_code == 200:
        print(f"Collection created: {collection_response.json()}")
    else:
        print(f"Error: {collection_response.text}")
    
    print("\n" + "="*50 + "\n")
    
    # 5. Get all collections
    print("5. Getting all collections...")
    collections_response = postman.get_collections()
    print(f"Status Code: {collections_response.status_code}")
    if collections_response.status_code == 200:
        collections = collections_response.json()
        print(f"Found {len(collections.get('collections', []))} collections")
        for collection in collections.get('collections', []):
            print(f"  - {collection.get('name')} ({collection.get('id')})")

if __name__ == "__main__":
    main()
