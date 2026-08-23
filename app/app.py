from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "RENUJA DevOps Project"

@app.route("/health")
def health():
    return {"status": "healthy"}

@app.route("/version")
def version():
    return {
        "application": "RENUJA DevOps Project",
        "version": "1.0.0"
    }


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
    

