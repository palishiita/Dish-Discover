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
def test_get_all_comments():
    user = create_users()[0]
    recipe = create_recipes(user)
    comments = create_comments_list(user, recipe)
    client = Client()
    url = f'/api/recipes/comments/'
    response = client.get(url)
    data = response.json()


    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'
    for item, com in zip(data, comments):
        assert 'comment_id' in item, response.json()
        assert 'content' in item, response.json()
        assert 'recipe' in item, response.json()
        assert 'user' in item, response.json()
        assert item['content'] == com.content, json()
        assert item['recipe'] == com.recipe.recipe_id, json()
        assert item['user'] == com.user.user_id, json()



## TEST COMMENT BY USER
@pytest.mark.django_db
def test_get_comments_by_user():
    user = create_users()[0]
    recipe = create_recipes(user)[0]
    comments = create_comments(user, recipe)
    client = APIClient()
    client.force_authenticate(user)
    url = '/api/recipes/comments/byuser/'
    response = client.get(url)
    data = response.json()

    response = client.get(url)
    #breakpoint()

    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'
    for item, com in zip(data, comments):
        assert 'comment_id' in item, response.json()
        assert 'content' in item, response.json()
        assert 'recipe' in item, response.json()
        assert 'user' in item, response.json()
        assert item['content'] == com.content, json()
        assert item['recipe'] == com.recipe.recipe_id, json()
        assert item['user'] == com.user.user_id, json()


## TEST BY RECIPE
@pytest.mark.django_db
def test_get_comments_by_recipe():
    user = create_users()[0]
    recipes = create_recipes(user)
    comments = create_comments_list(user, recipes)
    client = APIClient()
    #client.force_authenticate(user)
    for recipe in recipes:
        url = f'/api/recipes/comments/byrecipe/{recipe.recipe_id}/'

        response = client.get(url)

        data = response.json()

        #response = client.get(url)
        #response = client.get(url, {'recipe_id':recipe.recipe_id})
        print(response.status_code)
        print(response.content)

        assert response.status_code == 200, response.json()
        assert response['Content-Type'] == 'application/json'
        for item, com in zip(data, comments):
            assert 'comment_id' in item, response.json()
            assert 'content' in item, response.json()
            assert 'recipe' in item, response.json()
            assert 'user' in item, response.json()
            assert item['content'] == com.content, json()
            assert item['recipe'] == com.recipe.recipe_id, json()
            assert item['user'] == com.user.user_id, json()