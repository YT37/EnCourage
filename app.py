import os

from flask import Flask, jsonify, request
from flask_cors import CORS

from braille import Sentence

app = Flask(__name__)
CORS(app)


@app.route("/")
def check():
    return "The Server is running.\nThe available routes are:\n1. /braid/cells\n2. /braid/cells-repr"


@app.route("/braid/cells", methods=["POST"])
def braille_cells():
    args = request.get_json()

    cells = [signal for signal, _ in Sentence(args["sentence"]).toSignal()]

    return jsonify({"cells": cells})


@app.route("/braid/cells-repr", methods=["POST"])
def braille_cells_repr():
    args = request.get_json()

    signal = list(Sentence(args["sentence"]).toSignal())

    cells = [cell for cell, _ in signal]
    repr_ = [repr_ for _, repr_ in signal]

    return jsonify({"cells": cells, "repr": repr_})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
