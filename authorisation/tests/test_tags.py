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



