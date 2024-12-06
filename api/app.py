from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({"message": "Welcome to the Shop API!"})

# Routes for the Shop API : items, baskets, users
@app.route("/items")
def items():
    return jsonify({"message": "List of all items"})

@app.route("/baskets")
def baskets():
    return jsonify({"message": "List of all baskets"})

@app.route("/users")
def users():
    return jsonify({"message": "List of all users"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
