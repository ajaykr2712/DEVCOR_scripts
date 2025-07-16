Docker Networking Lab:

We'll create two simple containers:
	- Container 1: A web application container running an NGINX web server
	- Container 2: A client container running a lightweight linux like Alpine which we will use to test connectivity to Container 1.
	
1. Create a user-defined Docker network
2. Launch both containers and attach them to this network
3. Test network communication between containers



Step 1: Create a User-defined Network

Create a Docker bridge network:

docker network create labnet

Check the network:

docker network ls

You'll see labnet listed:

NETWORK ID     NAME      DRIVER    SCOPE
...            labnet    bridge    local


Step 2: Launch the Web Server Container (Container 1)

Start an NGINX container named webserver and attach it to labnet:

docker run -d --name webserver --network labnet nginx

Verify the container:

docker ps

You’ll see:

CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS      NAMES
...            nginx     "/docker-entrypoint.…"   3 seconds ago   Up 2 seconds   80/tcp     webserver



Step 3: Launch the Client Container (Container 2)

Launch an Alpine container (client) with an interactive terminal attached to labnet:

docker run -it --name client --network labnet alpine sh

You’re now inside the Alpine container's shell (/ #).


Step 4: Test Connectivity

From inside the client container, test connectivity to webserver by using its container name (Docker's built-in DNS):

ping webserver

You should see successful responses:

PING webserver (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.086 ms
64 bytes from 172.18.0.2: seq=1 ttl=64 time=0.065 ms

Press Ctrl+C to stop pinging.

Next, test the NGINX web service:

apk add curl
curl webserver

You’ll see the HTML code from NGINX’s default homepage, confirming successful HTTP connectivity!



Step 5: 
Exit from Alpine shell:

exit

Remove the containers:

docker rm -f webserver client

Delete the network:

docker network rm labnet
