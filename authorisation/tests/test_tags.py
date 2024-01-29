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
        assert item['user'] == ptag.user.id, response.json()
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
        url = f'/api/recipes/recipes/{recipe.id}/tags/'
        response = client.get(url)
        data = json.loads(response.content)

        assert response.status_code == 200
        assert response['Content-Type'] == 'application/json'
        for item, tag in zip(data, recipeTags):
            assert 'id' in item, response.json()
            assert 'tag' in item, response.json()
            assert 'weight' in item, response.json()

            assert item['recipe'] == tag.recipe.id,  response.json()

@pytest.mark.django_db
def add_preferred_tag():
    client =Client()    
    tag_category = create_tagcategories()     
    user = create_users()[0]
    tags = create_tags(tag_category)
        
    for tag in tags:
        data = {
            'user':user.id,
            'tag': tag.id,
            'weight' : 0.8
        }
        
        url = f'/api/recipes/tags/'
        response = client.post(url, data)
        data = json.loads(response.content)
        client.post()

        assert PreferredTag.objects.all().count() == 1

@pytest.mark.django_db
def test_get_popular_not_predefined_tags():
    client =Client()    
    tag_category = create_tagcategories()     
    user = create_users()[0]
    not_predef_tags = create_notpredef_tags(tag_category)
    recipes = create_recipes(user)
    create_recipe_tags_list(not_predef_tags[0:2], recipes[0:2])
    #create_recipe_tags_list(not_predef_tags[3:-2], recipes[3:-2])
    create_recipe_tags_list([not_predef_tags[-1]], recipes)
    
    url = f'/api/recipes/tags/popularnotpredef/{len(not_predef_tags)}/'
    response = client.get(url)
    data = json.loads(response.content)
    print(not_predef_tags)
    print(data)

    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'
    assert not_predef_tags[-1].name == data[0]['name']
    for item, tag in zip(data, not_predef_tags):
        assert 'name' in item, response.json()
        assert 'tag_category' in item, response.json()
        assert 'is_predefined' in item, response.json()
        assert item['is_predefined'] == False, response.json()
        #make sure that the tags are sorted by the number of recipes they are used in


    # @action(detail=True, methods=['GET', ''], url_name='makepredefined', url_path='makepredefined')
    # def make_predefined(self, request, pk=None):
    #     tag = self.get_object()
    #     tag.is_predefined = True
    #     tag.save()
    #     serializer = TagSerializer(tag)
    #     return Response(serializer.data)
        
@pytest.mark.django_db
def test_make_predefined():
    client =Client()    
    tag_category = create_tagcategories()     
    user = create_users()[0]
    not_predef_tags = create_notpredef_tags(tag_category)

    url = f'/api/recipes/tags/{not_predef_tags[0].pk}/makepredefined/'
    response = client.post(url)
    assert response.status_code == 200
    not_predef_tags[0].refresh_from_db()
    assert not_predef_tags[0].is_predefined == True
 