import os
import socket

from flask import Flask

app = Flask(__name__)

MESSAGE = os.environ.get("MESSAGE", "Hello from Cloud Run!")


@app.route("/")
def index():
    # Cloud Run sets K_SERVICE and K_REVISION; locally they are unset.
    service = os.environ.get("K_SERVICE", "local")
    revision = os.environ.get("K_REVISION", "local")
    return f"""<!doctype html>
<html>
  <head><title>{service}</title></head>
  <body style="font-family: sans-serif; text-align: center; margin-top: 15vh">
    <h1>{MESSAGE}</h1>
    <p>service: <code>{service}</code> &middot; revision: <code>{revision}</code></p>
    <p>host: <code>{socket.gethostname()}</code></p>
  </body>
</html>
"""


@app.route("/healthz")
def healthz():
    return "ok"


if __name__ == "__main__":
    # Cloud Run tells the container which port to listen on via $PORT.
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", "8080")))
