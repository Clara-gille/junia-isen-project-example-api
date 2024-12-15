import pytest
from api.app import app

@pytest.fixture
def client():
    app.testing = True
    with app.test_client() as client:
        yield client

# Test pour la route GET "/"
def test_home(client):
    response = client.get("/")
    assert response.status_code == 200
    assert response.json == {"message": "Welcome to the Shop API!"}

# Test pour la route GET "/items" sans ajout
def test_get_items(client):
    response = client.get("/items")
    assert response.status_code == 200
    assert isinstance(response.json["items"], list)  # Vérifie que la réponse contient une liste d'items
    assert len(response.json["items"]) >= 0  # Vérifie qu'il n'y a pas d'items négatifs dans la liste

# Test pour la route GET "/baskets" sans ajout
def test_get_baskets(client):
    response = client.get("/baskets")
    assert response.status_code == 200
    assert isinstance(response.json["baskets"], list)  # Vérifie que la réponse contient une liste de paniers
    assert len(response.json["baskets"]) >= 0  # Vérifie qu'il n'y a pas de paniers négatifs dans la liste

# Test pour la route GET "/users" sans ajout
def test_get_users(client):
    response = client.get("/users")
    assert response.status_code == 200
    assert isinstance(response.json["users"], list)  # Vérifie que la réponse contient une liste d'utilisateurs
    assert len(response.json["users"]) >= 0  # Vérifie qu'il n'y a pas d'utilisateurs négatifs dans la liste
