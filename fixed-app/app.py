from flask import Flask, jsonify

import config

app = Flask(__name__)


@app.route("/")
def index():
    return jsonify(status="ok", service="trivy-lab")


@app.route("/version")
def version():
    return jsonify(debug=config.DEBUG)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
