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

    assert 'recipe' in data
    recipe_data = data['recipe']

    assert 'recipe_id' in recipe_data
    assert 'author' in recipe_data
    assert 'recipe_name' in recipe_data

    # Add more assertions for other fields as needed
    assert recipe_data['recipe_id'] == recipe.recipe_id
    assert recipe_data['author'] == recipe.author.user_id
    assert recipe_data['recipe_name'] == recipe.recipe_name
    # Add more assertions for other fields as needed


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