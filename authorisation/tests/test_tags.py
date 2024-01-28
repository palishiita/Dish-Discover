# myapp/tests.py
from django.test import Client
from django.urls import reverse
from authorisation.tests.test_data import *
from recipes.models import *
import json
import pytest 
from rest_framework.test import APIClient

# TAGS
@pytest.mark.django_db
def test_get_all_tags():

    tag_category = create_tagcategories()
    tags = create_tags(tag_category)
    user = create_users()[0]
    client = Client()
    url = f'/api/recipes/tags/'
    response = client.get(url)
    data = response.json()

    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'
    for item in data:
        assert 'is_predefined' in item, response.json()
        assert 'name' in item, response.json()
        assert 'tag_category' in item, response.json()


@pytest.mark.django_db
def test_tag_category():
    tag_categories = create_tagcategories()

    client = Client()
    url = f'/api/recipes/tagcategories/'
    response = client.get(url)
    data = response.json()

    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'
    for item, category in zip(data, tag_categories):
        assert 'category_name' in item, response.json()
        assert item['category_name'] == category.category_name, response.json()


# PREFERRED TAGS
@pytest.mark.django_db
def test_get_preferred_tags():
    tag_category = create_tagcategories()      
    user = create_users()[0]
    tags = create_tags(tag_category)
    preferred_tags= create_preferred_tags(user, tags)
    

    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/preferredtags/'
    response = client.get(url)
    data = response.json()

    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'
    # breakpoint()
    for item, ptag in zip(data, preferred_tags):
        assert 'id' in item, response.json()
        assert 'tag' in item, response.json()
        assert 'user' in item, response.json()
        assert 'weight' in item, response.json()
        assert item['id'] == ptag.id, response.json()
        assert item['tag'] == ptag.tag.name, response.json()
        assert item['user'] == ptag.user.user_id, response.json()
        assert item['weight'] == ptag.weight, response.json()



# TAGS OF A SIGNLE RECIPE
@pytest.mark.django_db
def test_get_recipe_tags():
    client =Client()    
    tag_category = create_tagcategories()   
    user = create_users()[0]
    tags = create_tags(tag_category)
    
    recipes = create_recipes(user)

    recipeTags = create_recipe_tags_list(tags, recipes)

    for recipe in recipes:
        url = f'/api/recipes/recipes/{recipe.recipe_id}/tags/'
        response = client.get(url)
        data = json.loads(response.content)

        assert response.status_code == 200
        assert response['Content-Type'] == 'application/json'
        for item, tag in zip(data, recipeTags):
            assert 'id' in item, response.json()
            assert 'tag' in item, response.json()
            assert 'weight' in item, response.json()

            assert item['recipe'] == tag.recipe.recipe_id,  response.json()

def add_preferred_tag():
    client =Client()    
    tag_category = create_tagcategories()     
    user = create_users()[0]
    tags = create_tags(tag_category)
        
    for tag in tags:
        data = {
            'user':user.user_id,
            'tag': tag.id,
            'weight' : 0.8
        }
        
        url = f'/api/recipes/tags/'
        response = client.post(url, data)
        data = json.loads(response.content)
        client.post()

        assert PreferredTag.objects.all().count() == 1