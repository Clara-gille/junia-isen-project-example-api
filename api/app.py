import os
import psycopg2
from flask import Flask, jsonify, request

app = Flask(__name__)

# Variables d'environnement pour la base de données
DATABASE_HOST = os.getenv('DATABASE_HOST')
DATABASE_PORT = os.getenv('DATABASE_PORT', '5432')
DATABASE_USER = os.getenv('DATABASE_USER')
DATABASE_PASSWORD = os.getenv('DATABASE_PASSWORD')
DATABASE_NAME = os.getenv('DATABASE_NAME')

# Connexion à la base de données PostgreSQL
def get_db_connection():
    conn = psycopg2.connect(
        host=DATABASE_HOST,
        port=DATABASE_PORT,
        user=DATABASE_USER,
        password=DATABASE_PASSWORD,
        dbname=DATABASE_NAME,
        connect_timeout=10,
    )
    return conn

# Fonction pour créer les tables si elles n'existent pas
def create_tables():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
    CREATE TABLE IF NOT EXISTS items (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255),
        price DECIMAL
    )
    """)

    cur.execute("""
    CREATE TABLE IF NOT EXISTS baskets (
        id SERIAL PRIMARY KEY,
        user_id INTEGER,
        item_id INTEGER
    )
    """)

    cur.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255),
        email VARCHAR(255)
    )
    """)

    conn.commit()
    cur.close()
    conn.close()

# Appel de la fonction pour créer les tables au démarrage de l'application
create_tables()

@app.route("/")
def home():
    return jsonify({"message": "Welcome to the Shop API!"})

# Routes pour les items
@app.route("/items", methods=["GET", "POST"])
def handle_items():
    conn = get_db_connection()
    cur = conn.cursor()

    if request.method == "GET":
        cur.execute("SELECT * FROM items")
        items = cur.fetchall()
        cur.close()
        conn.close()
        return jsonify({"items": items})

    elif request.method == "POST":
        data = request.get_json()
        name = data.get('name')
        price = data.get('price')

        if not name or not price:
            return jsonify({"error": "Name and price are required"}), 400
        
        cur.execute("INSERT INTO items (name, price) VALUES (%s, %s) RETURNING id", (name, price))
        item_id = cur.fetchone()[0]
        conn.commit()
        cur.close()
        conn.close()
        return jsonify({"message": "Item created", "item_id": item_id}), 201

# Routes pour les baskets
@app.route("/baskets", methods=["GET", "POST"])
def handle_baskets():
    conn = get_db_connection()
    cur = conn.cursor()

    if request.method == "GET":
        cur.execute("SELECT * FROM baskets")
        baskets = cur.fetchall()
        cur.close()
        conn.close()
        return jsonify({"baskets": baskets})

    elif request.method == "POST":
        data = request.get_json()
        user_id = data.get('user_id')
        item_id = data.get('item_id')

        if not user_id or not item_id:
            return jsonify({"error": "User ID and Item ID are required"}), 400

        cur.execute("INSERT INTO baskets (user_id, item_id) VALUES (%s, %s) RETURNING id", (user_id, item_id))
        basket_id = cur.fetchone()[0]
        conn.commit()
        cur.close()
        conn.close()
        return jsonify({"message": "Basket created", "basket_id": basket_id}), 201

# Routes pour les utilisateurs
@app.route("/users", methods=["GET", "POST"])
def handle_users():
    conn = get_db_connection()
    cur = conn.cursor()

    if request.method == "GET":
        cur.execute("SELECT * FROM users")
        users = cur.fetchall()
        cur.close()
        conn.close()
        return jsonify({"users": users})

    elif request.method == "POST":
        data = request.get_json()
        name = data.get('name')
        email = data.get('email')

        if not name or not email:
            return jsonify({"error": "Name and email are required"}), 400

        cur.execute("INSERT INTO users (name, email) VALUES (%s, %s) RETURNING id", (name, email))
        user_id = cur.fetchone()[0]
        conn.commit()
        cur.close()
        conn.close()
        return jsonify({"message": "User created", "user_id": user_id}), 201

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
