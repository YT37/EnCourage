import os

from flask import Flask, jsonify, request
from flask_cors import CORS

from braille import Sentence

app = Flask(__name__)
CORS(app)


@app.route("/")
def check():
    return "The Server is running.\nThe available routes are:\n1. /braille/cells\n2. /braille/cells-repr"


@app.route("/braille/cells", methods=["POST"])
def braille_cells():
    print("Func Called")

    args = request.get_json()
    print(args["sentence"])

    cells = [signal for signal, _ in Sentence(args["sentence"]).toSignal()]
    print(cells)

    return jsonify({"cells": cells})


@app.route("/braille/cells-repr", methods=["POST"])
def braille_cells_repr():
    print("Func Called")

    args = request.get_json()
    print(args["sentence"])

    signal = list(Sentence(args["sentence"]).toSignal())
    print(signal)

    cells = [cell for cell, _ in signal]
    repr_ = [repr_ for repr_ in signal]
    print(cells)
    print(repr_)

    return jsonify({"cells": cells, "repr": repr_})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
