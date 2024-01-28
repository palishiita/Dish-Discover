# myapp/tests.py
from django.test import Client
from django.urls import reverse
from authorisation.tests.test_data import *
from recipes.models import *
import json
import pytest 
from rest_framework.test import APIClient

## TEST INGREDIENS
@pytest.mark.django_db
def test_get_all_ingredients():
    user =  create_users()[0]
    tag_category = create_tagcategories()  
    tag = create_tags(tag_category)
    ingredients = create_ingredients(tag)
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
    tagCategory =  create_tagcategories()
    tag = create_tags(tagCategory)
    ingredient = create_ingredients(tag)

    client = Client()

    for ingredient in ingredient:
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
    user = create_users()
    recipe = create_recipes(user[0])
    tag_category = create_tagcategories()   
    tag = create_tags(tag_category)   
    ingredients = create_ingredients(tag)

    recipeIngredients = create_recipe_ingredients_list(ingredients, recipe)


    client = Client()
    for recipe in recipe:
        url = f'/api/recipes/recipes/{recipe.recipe_id}/ingredients/'
        response = client.get(url)
        data = response.json()
    
        assert response.status_code == 200
        assert response['Content-Type'] == 'application/json'
        for item in data:
            assert 'amount' in item, response.json()


