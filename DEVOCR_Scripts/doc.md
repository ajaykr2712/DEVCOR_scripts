Step 1: Create a directory named 'docker_app'
Step 2:  Create a file '.envrc' with below code:
export COURSE="Developing Applications using Cisco Core Platforms and APIs"

Step 3: Create another file 'program.py' with below code:

from flask import Flask
import os


# Instantiate an application
app = Flask(__name__)

@app.route("/")
def home():
    course = os.environ['COURSE']
    return f"Welcoem to Cisco DevNet {course}!"


if __name__=="__main__":
    app.run(debug=True, host="0.0.0.0")

Step 4: Install flask library using 'pip install flask' command

Step 5: Run the app using 'python program.py' command

Step 6: Test if the app is running by browsing 'localhost:5000' in browser.

Step 7: Convert the app into docker image by creating a 'dockerfile' named file in same directory with below code:

# Flask app example definition
FROM python:3.8

ENV COURSE=DEVCORE

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt
EXPOSE 5000

ENTRYPOINT [ "python3" ]
CMD [ "program.py" ]

Step 8: package the library requirements in another file named 'requirements.txt' with below code:
flask==3.0.0

Step9: Build the docker image using 'sudo docker build -t example-app .' command.

Step 10: After image created check if its there using 'sudo docker image ls' command.

Step 11: Run the image using 'sudo docker run -dit -p 5000:5000 example-app' command

Step 12: Test it by browsing 'localhost:5000'

Step 13: Stop the container using 'sudo docker stop <container_id>' command.