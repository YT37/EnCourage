import os

from flask import Flask, jsonify, request
from flask_cors import CORS

from braille import Sentence

app = Flask(__name__)
CORS(app)


@app.route("/")
def running_check():
    return "The Server is running"


@app.route("/generate_braille", methods=["POST"])
def generate_braille():
    args = request.get_json()

    response = [signal for signal, _ in Sentence(args["sentence"].lower()).toSignal()]

    return jsonify({"response": response})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
