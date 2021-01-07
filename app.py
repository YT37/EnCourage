import os

from flask import Flask, request
from flask_cors import CORS

from braille import Sentence

app = Flask(__name__)
CORS(app)


@app.route("/")
def running_check():
    return "The Server is running"


@app.route("/generate_braille/<string:word>")
def generate_braille(word):
    response = [signal for signal, _ in Sentence(word.lower()).toSignal()]

    return response


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
