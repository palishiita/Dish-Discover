# myapp/tests.py
from django.test import Client
from django.urls import reverse
from DishDiscoverDjango.models import *
import json
import pytest 
from rest_framework.test import APIClient

def create_user():
    return DishDiscoverUser.objects.create(user_id = 3, username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    
# TAGS
@pytest.mark.django_db
def test_get_all_tags():

    tag_category = TagCategory.objects.create(category_name='Cousine')
    tags = [
        Tag.objects.create(name='Polish',tag_category=tag_category, is_predefined = True),
        Tag.objects.create(name='Easy',tag_category=tag_category, is_predefined = True),
        Tag.objects.create(name='Tomato',tag_category=tag_category, is_predefined = True),
        Tag.objects.create(name='Avocado',tag_category=tag_category, is_predefined = True)
        ]
    user = create_user()
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
    tag_categories = [
        TagCategory.objects.create(category_name='Test Category 1'),
        TagCategory.objects.create(category_name='Test Category 2')
    ]

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
    tag_category = TagCategory.objects.create(category_name='Cousine')      
    user = create_user()
    tags = [
        Tag.objects.create(name='Polish',tag_category=tag_category,is_predefined = True),
        Tag.objects.create(name='Easy',tag_category=tag_category,is_predefined = True),
        Tag.objects.create(name='Tomato',tag_category=tag_category,is_predefined = True),
        Tag.objects.create(name='Avocado',tag_category=tag_category,is_predefined = True)
        ]
    preferred_tags=[
        PreferredTag.objects.create(user=user, tag=tags[0], weight=0.8),
        PreferredTag.objects.create(user=user, tag=tags[1], weight=0.8),
        PreferredTag.objects.create(user=user, tag=tags[2], weight=0.8),
        PreferredTag.objects.create(user=user, tag=tags[3], weight=0.8),
    ]
    

    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/tags/preferred/'
    response = client.get(url)
    data = response.json()

    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'

    for item, tag in zip(data, preferred_tags):
        assert 'id' in item, response.json()
        assert 'tag' in item, response.json()
        assert 'user' in item, response.json()
        assert 'weight' in item, response.json()
        assert item['id'] == tag.id, response.json()
        assert item['tag'] == tag.tag.name, response.json()
        assert item['user'] == tag.user.user_id, response.json()
        assert item['weight'] == tag.weight, response.json()



# TAGS OF A SIGNLE RECIPE
@pytest.mark.django_db
def test_get_recipe_tags():
    client =Client()    
    tag_category = TagCategory.objects.create(category_name='Cousine')      
    user = create_user()
    tags = [
        Tag.objects.create(name='Polish',tag_category=tag_category,is_predefined = True),
        Tag.objects.create(name='Easy',tag_category=tag_category,is_predefined = True),
        Tag.objects.create(name='Tomato',tag_category=tag_category,is_predefined = True),
        Tag.objects.create(name='Avocado',tag_category=tag_category,is_predefined = True)
        ]
    
    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.user_id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )

    recipeTags = [
        RecipeTag.objects.create(recipe=recipe, tag=tags[0], weight=0.8),
        RecipeTag.objects.create(recipe=recipe, tag=tags[1], weight=0.5),
        RecipeTag.objects.create(recipe=recipe, tag=tags[2], weight=0.9),
    ]

    url = f'/api/recipes/{recipe.recipe_id}/tags/'
    response = client.get(url)
    data = json.loads(response.content)

    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'
    for item, tag in zip(data, recipeTags):
        assert 'id' in item, response.json()
        assert 'tag' in item, response.json()
        assert 'weight' in item, response.json()

        assert item['recipe'] == tag.recipe.recipe_id,  response.json()

