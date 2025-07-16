# Import the libraries to execute API call for Postman API
import requests
from urllib3 import disable_warnings

# Disable Warnings
disable_warnings()

# Define the URL, Headers, and Request Body to execute the API Call
# Example: Create a new collection in Postman
postman_url = "https://api.getpostman.com/collections"
postman_headers = {
    "X-API-Key": "YOUR_POSTMAN_API_KEY_HERE",
    "Content-Type": "application/json",
}

# Collection payload for creating a new collection
postman_collection_payload = {
    "collection": {
        "info": {
            "name": "DevOCR Training Collection",
            "description": "A collection created for DevOCR training purposes",
            "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
        },
        "item": [
            {
                "name": "Sample Request",
                "request": {
                    "method": "GET",
                    "header": [],
                    "url": {
                        "raw": "https://httpbin.org/get",
                        "protocol": "https",
                        "host": ["httpbin", "org"],
                        "path": ["get"]
                    }
                }
            }
        ]
    }
}

# Execute the POST API call to create the collection and store the response in variable
response = requests.post(
    url=postman_url, headers=postman_headers, json=postman_collection_payload, verify=False
)

# Print status code and json output
print(f"Status Code: {response.status_code}")
print(f"Response Headers: {dict(response.headers)}")
print(f"Response JSON: {response.json()}")

# Additional functionality - Get all collections
print("\n" + "="*50)
print("Getting all collections...")

get_collections_response = requests.get(
    url=postman_url, headers=postman_headers, verify=False
)

print(f"Get Collections Status Code: {get_collections_response.status_code}")
print(f"Collections: {get_collections_response.json()}")
