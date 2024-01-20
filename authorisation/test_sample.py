# myapp/tests.py
from django.test import Client
from django.urls import reverse
from DishDiscoverDjango.models import DishDiscoverUser, Recipe
import json
import pytest 

def test_dummy():
    assert True

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
    url = f'/api/recipe/{recipe.recipe_id}/'

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
