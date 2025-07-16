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
