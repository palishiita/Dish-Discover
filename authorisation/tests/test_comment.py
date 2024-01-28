# myapp/tests.py
from django.test import Client
from django.urls import reverse
from recipes.models import *
import json
import pytest 
from rest_framework.test import APIClient



def create_user():
    return DishDiscoverUser.objects.create(user_id = 3, username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    
## TEST INGREDIENS
@pytest.mark.django_db
def test_get_all_comments():
    user = create_user()
    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.user_id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )
    comments = [
        Comment.objects.create(user=user, recipe=recipe, content='This chocolate cake is amazing!'),
        Comment.objects.create(user=user, recipe=recipe, content='I love spaghetti bolognese!')
    ]
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


def create_user():
    return DishDiscoverUser.objects.create(user_id = 3, username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    


## TEST COMMENT BY USER
@pytest.mark.django_db
def test_get_comments_by_user():
    user = create_user()
    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.user_id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )
    comments = [
        Comment.objects.create(user=user, recipe=recipe, content='This chocolate cake is amazing!'),
        Comment.objects.create(user=user, recipe=recipe, content='I love spaghetti bolognese!')
    ]
    client = APIClient(user)
    client.force_authenticate(user)
    url = '/api/recipes/comments/byuser/'
    response = client.get(url)
    data = response.json()

    response = client.get(url)
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


## TEST BY RECIPE
@pytest.mark.django_db
def test_get_comments_by_recipe():
    user = create_user()
    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.user_id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )
    comments = [
        Comment.objects.create(user=user, recipe=recipe, content='This chocolate cake is amazing!'),
        Comment.objects.create(user=user, recipe=recipe, content='I love spaghetti bolognese!')
    ]
    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/comments/byrecipe/'
    response = client.get(url)
    data = response.json()

    response = client.get(url, {'recipe_id':recipe.recipe_id})
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