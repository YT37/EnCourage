from braille import Braille
from flask import Flask, jsonify, request
from flask_cors import CORS
from sign import Sign

testing = True

app = Flask(__name__)
CORS(app)


@app.route("/")
def running_check():
    return "The Server is running."


@app.route("/braille", methods=["POST"])
def braille():
    args = request.args

    translaion = list(Braille(args.get("text")).translate())

    return jsonify(
        {
            "output": [cell for cell, _ in translaion],
            "captions": [captions for _, captions in translaion],
        }
    )


@app.route("/sign", methods=["POST"])
def sign():
    args = request.args

    translaion = list(Sign(args.get("text")).translate())

    return jsonify(
        {
            "output": [sign for sign, _ in translaion],
            "captions": [captions for _, captions in translaion],
        }
    )


if __name__ == "__main__":
    app.run(debug=testing)
