# myapp/tests.py
# from django.test import Client
# from django.urls import reverse
# from DishDiscoverDjango.models import Recipe
# import json

def test_get_recipe_view():
    recipe = Recipe.objects.create(
        recipe_id=1,
        author_id=1,
        recipe_name="Test Recipe",
        content="Test content",
        picture="test.jpg",
        description="Test description",
        is_boosted=False
    )

    client = Client()

    # Build the URL for the view with the recipe ID
    url = f'/recipe/{recipe.recipe_id}/'

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
