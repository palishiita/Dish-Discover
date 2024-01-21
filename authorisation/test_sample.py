# myapp/tests.py
from django.test import Client
from django.urls import reverse
from DishDiscoverDjango.models import DishDiscoverUser, Recipe
import json
import pytest 
from rest_framework.test import APIClient


@pytest.mark.django_db

def test_get_recipe_view():
    user = DishDiscoverUser.objects.create(username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )

    client = Client()

    # Build the URL for the view with the recipe ID
    url = f'/api/recipes/recipes/{recipe.recipe_id}/'

    response = client.get(url)

    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'

    data = json.loads(response.content)

    # Adjust assertions based on the structure of your serialized data
    assert 'recipe_id' in data
    assert 'author' in data
    assert 'recipe_name' in data

    # Add more assertions for other fields as needed
    assert data['recipe_id'] == recipe.recipe_id
    assert data['author'] == recipe.author.user_id
    assert data['recipe_name'] == recipe.recipe_name
    # Add more assertions for other fields as needed

@pytest.mark.django_db
def test_get_all_recipes():
    user = DishDiscoverUser.objects.create(username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    client = Client()

    # Build the URL for the view with the recipe ID
    url = f'/api/recipes/recipes/'
    response = client.get(url)
    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'

    data = json.loads(response.content)

@pytest.mark.django_db
def test_get_all_tags():
    user = DishDiscoverUser.objects.create(username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    client = Client()
    url = f'/api/recipes/tags/'
    response = client.get(url)
    assert response.status_code == 200

@pytest.mark.django_db
def test_registration_view_success():
    client = APIClient()

    # Prepare data for a valid registration
    valid_data = {
        'username': 'testuser',
        'email': 'test@example.com',
        'password': 'testpassword',
    }

    url = '/api/auth/register'

    # Make a POST request to the registration view
    response = client.post(url, valid_data)

    # Check if the response status code is 200 (OK)
    assert response.status_code == 200


    # Check if the serializer is val