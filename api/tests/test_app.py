# import pytest
# from api.app import app

# @pytest.fixture
# def client():
#     app.testing = True
#     with app.test_client() as client:
#         yield client

# # Test pour la route GET "/"
# def test_home(client):
#     response = client.get("/")
#     assert response.status_code == 200
#     assert response.json == {"message": "Welcome to the Shop API!"}


# # Test pour la route GET "/items" avant l'ajout
# def test_get_items_before_post(client):
#     response = client.get("/items")
#     assert response.status_code == 200
#     assert isinstance(response.json["items"], list)  # Vérifie que la réponse contient une liste d'items
#     assert len(response.json["items"]) == 0  # Vérifie qu'aucun item n'est encore dans la liste

# # Test pour la route POST "/items"
# def test_post_item(client):
#     new_item = {
#         "name": "Laptop",
#         "price": 1200.50
#     }
#     response = client.post("/items", json=new_item)
#     assert response.status_code == 201  # Vérifie que la création a bien renvoyé un code 201
#     assert response.json["message"] == "Item created"
#     assert "item_id" in response.json  # Vérifie que l'ID de l'item est retourné

# # Test pour la route GET "/items" après l'ajout
# def test_get_items_after_post(client):
#     response = client.get("/items")
#     assert response.status_code == 200
#     assert isinstance(response.json["items"], list)  # Vérifie que la réponse contient une liste d'items
#     assert len(response.json["items"]) > 0  # Vérifie qu'il y a maintenant des items dans la liste


# # Test pour la route GET "/baskets" avant l'ajout
# def test_get_baskets_before_post(client):
#     response = client.get("/baskets")
#     assert response.status_code == 200
#     assert isinstance(response.json["baskets"], list)  # Vérifie que la réponse contient une liste de paniers
#     assert len(response.json["baskets"]) == 0  # Vérifie qu'aucun panier n'est encore dans la liste

# # Test pour la route POST "/baskets"
# def test_post_basket(client):
#     new_basket = {
#         "user_id": 1,
#         "items": [{"item_id": 1, "quantity": 2}]
#     }
#     response = client.post("/baskets", json=new_basket)
#     assert response.status_code == 201  # Vérifie que la création a bien renvoyé un code 201
#     assert response.json["message"] == "Basket created"
#     assert "basket_id" in response.json  # Vérifie que l'ID du panier est retourné

# # Test pour la route GET "/baskets" après l'ajout
# def test_get_baskets_after_post(client):
#     response = client.get("/baskets")
#     assert response.status_code == 200
#     assert isinstance(response.json["baskets"], list)  # Vérifie que la réponse contient une liste de paniers
#     assert len(response.json["baskets"]) > 0  # Vérifie qu'il y a maintenant des paniers dans la liste


# # Test pour la route GET "/users" avant l'ajout
# def test_get_users_before_post(client):
#     response = client.get("/users")
#     assert response.status_code == 200
#     assert isinstance(response.json["users"], list)  # Vérifie que la réponse contient une liste d'utilisateurs
#     assert len(response.json["users"]) == 0  # Vérifie qu'aucun utilisateur n'est encore dans la liste

# # Test pour la route POST "/users"
# def test_post_user(client):
#     new_user = {
#         "username": "john_doe",
#         "email": "john.doe@example.com",
#         "password": "securepassword123"
#     }
#     response = client.post("/users", json=new_user)
#     assert response.status_code == 201  # Vérifie que la création a bien renvoyé un code 201
#     assert response.json["message"] == "User created"
#     assert "user_id" in response.json  # Vérifie que l'ID de l'utilisateur est retourné

# # Test pour la route GET "/users" après l'ajout
# def test_get_users_after_post(client):
#     response = client.get("/users")
#     assert response.status_code == 200
#     assert isinstance(response.json["users"], list)  # Vérifie que la réponse contient une liste d'utilisateurs
#     assert len(response.json["users"]) > 0  # Vérifie qu'il y a maintenant des utilisateurs dans la liste
