# myapp/tests.py
from django.test import Client
from django.urls import reverse
from DishDiscoverDjango.models import *
import json
import pytest 
from rest_framework.test import APIClient

def create_user():
    return DishDiscoverUser.objects.create(user_id = 3, username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    
## TEST INGREDIENS
@pytest.mark.django_db
def test_get_all_ingredients():
    user =  DishDiscoverUser.objects.create(username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    tag_category = TagCategory.objects.create(category_name='Cousine')   
    tag = Tag.objects.create(name='Polish',tag_category=tag_category,is_predefined = True)
    ingredients = [
        Ingredient.objects.create(ingredient_id = 1, name='Tomato', calorie_density=20.0, tag = tag),
        Ingredient.objects.create(ingredient_id = 2, name='Avocado', calorie_density=50.0, tag =tag )
    ]
    client = Client()
    url = f'/api/recipes/ingredients/'
    response = client.get(url)
    data = response.json()


    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'
    for item in data:
        assert 'calorie_density' in item, response.json()
        assert 'ingredient_id' in item, response.json()
        assert 'tag' in item, response.json()


@pytest.mark.django_db
def test_get_ingredient():
    tagCategory =  TagCategory.objects.create(category_name='Cousine')
    tag = Tag.objects.create(name='Polish',tag_category=tagCategory,is_predefined = True)
    ingredient = Ingredient.objects.create(ingredient_id=10, name='Tomato', calorie_density=20.0, tag=tag)

    client = Client()
    url = f'/api/recipes/ingredients/{ingredient.ingredient_id}/'
    response = client.get(url)
    data = response.json()

    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'
    assert 'calorie_density' in data, response.json()
    assert 'ingredient_id' in data, response.json()
    assert 'tag' in data, response.json()


# INGREDIENTS OF THE SINGLE RECIPE
@pytest.mark.django_db
def test_get_recipe_ingredients():
    user = create_user()
    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.user_id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )
    tag_category = TagCategory.objects.create(category_name='Cousine')   
    tag = Tag.objects.create(name='Polish',tag_category=tag_category,is_predefined = True)    
    ingredients = [
        Ingredient.objects.create(ingredient_id = 1, name='Tomato', calorie_density=20.0, tag = tag),
        Ingredient.objects.create(ingredient_id = 2, name='Avocado', calorie_density=50.0, tag =tag )
    ]

    recipeIngredients = [
    RecipeIngredient.objects.create(recipe=recipe, ingredient= ingredients[0], amount=200.0, unit='g'),
    RecipeIngredient.objects.create(recipe=recipe, ingredient= ingredients[1], amount=250.0, unit='g')
    ]


    client = Client()
    url = f'/api/recipes/{recipe.recipe_id}/ingredients/'
    response = client.get(url)
    data = response.json()
    
    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'
    for item in data:
        assert 'amount' in item, response.json()


