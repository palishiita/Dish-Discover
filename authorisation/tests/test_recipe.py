# myapp/tests.py
from django.test import Client
from django.urls import reverse
from authorisation.tests.test_data import *
from recipes.models import *
import json
import pytest 
from rest_framework.test import APIClient

# RECIPE TESTS 

# ALL RECIPES
@pytest.mark.django_db
def test_get_all_recipes():
    
    client = APIClient()

    # Build the URL for the view with the recipe ID
    url = f'/api/recipes/recipes/'
    user = create_users()[0]

    recipe = create_recipes(user)

    client.force_authenticate(user)
    response = client.get(url)
    data = response.json()

    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'

    for item in data:
        assert 'author' in item, response.json()
        assert 'content' in item, response.json()
        assert 'description' in item, response.json()
        assert 'ingredients' in item, response.json()
    

#RECIPE BY ID
@pytest.mark.django_db

def test_get_recipe_view():
    user = create_users()[0]
    recipe = create_recipes(user)[0]

    client = Client()

    # Build the URL for the view with the recipe ID
    url = f'/api/recipes/recipes/{recipe.id}/'

    response = client.get(url)
    data = json.loads(response.content)

    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'
    assert 'id' in data
    assert 'author' in data
    assert 'recipe_name' in data
    assert data['id'] == recipe.id
    assert data['author'] == recipe.author.id
    assert data['recipe_name'] == recipe.recipe_name

@pytest.mark.django_db
def test_add_recipe():
    client = APIClient()
    # Build the URL for the view with the recipe ID
    url = f'/api/recipes/recipes/'
    user = create_users()[0]

    data={
        'id':10,
        'author':user.id,
        'recipe_name':"Test Recipe",
        'content':"Test content",
        'description':"Test description",
        'is_boosted':False
        }

    client.force_authenticate(user)
    response = client.post(url, data)
    data = response.json()

    assert Recipe.objects.all().count() == 1


# LIKED RECIPES
@pytest.mark.django_db
def test_get_liked_recipes():
    user = create_users()[0]
    recipe = create_recipes(user)
    create_liked_recipes(user, recipe)
    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/liked/'
    response = client.get(url)
    data = response.json()

    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'
    for item in data:
        assert 'id' in item, response.json()
        assert 'recipe' in item, response.json()
        assert 'user' in item, response.json()


# LIKED RECIPES
@pytest.mark.django_db
def test_delete_liked_recipe():
    user = create_users()[0]
    recipe = create_recipes(user)[0]
    liked = create_liked_recipes(user, [recipe])[0]
    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/liked/{liked.id}/'
    response = client.delete(url)


    assert LikedRecipe.objects.filter(user=user, recipe=recipe).count() == 0

@pytest.mark.django_db
def test_delete_liked_recipe_when_2_liked():
    user = create_users()[0]
    recipes = create_recipes(user)
        
    liked_recipes = create_liked_recipes(user, recipes)
    
    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/liked/{liked_recipes[0].id}/'
    response = client.delete(url)


    assert LikedRecipe.objects.filter(user=user, recipe=recipes[0]).count() == 0
    assert LikedRecipe.objects.all().count() == len(liked_recipes) - 1

    # assert response.status_code == 200, response.json()
    # assert response['Content-Type'] == 'application/json'
    # for item in data:
    #     assert 'id' in item, response.json()
    #     assert 'recipe' in item, response.json()
    #     assert 'user' in item, response.json()

# LIKED RECIPES
@pytest.mark.django_db
def test_update_recipes():
    user = create_users()[0]
    recipe = create_recipes(user)[0]

    data = {
        'id': recipe.id,
        'author':user.id,
        'recipe_name':'Test Recipe 2',
        'content':'Test content 2',
        'description':recipe.description,
        'is_boosted': False
    }
    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/recipes/{recipe.id}/'
    response = client.put(url, data)
    data = response.json()

    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'
    assert 'author' in data
    assert 'recipe_name' in data
    assert 'content' in data
    assert data['recipe_name'] == 'Test Recipe 2'
    assert data['content'] == 'Test content 2'


@pytest.mark.django_db
def test_add_lked_recipe():
    user = create_users()[0]

    recipe = create_recipes(user)[0]
    # saved_recipe = SavedRecipe(user=user, recipe=recipe, is_recommendation=True)
    # saved_recipe = SavedRecipe.objects.create(user=user, recipe=recipe, is_recommendation=True)
    client = APIClient()
    client.force_authenticate(user)
    
    url = '/api/recipes/liked/'
    data = {'user': user.id, 'recipe': recipe.id, 'is_recommendation': True}
    response = client.post(url, data)
    assert LikedRecipe.objects.filter(user=user, recipe=recipe).count() == 1
    assert LikedRecipe.objects.all().count() == 1
# SAVED RECIPES
    
@pytest.mark.django_db
def test_get_saved_recipes():
    users= create_users()
    user1 = users[0]
    user2 = users[1]

    recipe = create_recipes(user1)
    create_saved_recipes(user1, recipe)
    create_saved_recipes(user2, recipe)
    
    client = APIClient(user1)
    client.force_authenticate(user1)
    url = f'/api/recipes/saved/'
    response = client.get(url)
    data = response.json()

    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'
    for item in data:
        assert 'id' in item, response.json()
        assert 'recipe' in item, response.json()
        assert 'user' in item, response.json()


@pytest.mark.django_db
def test_delete_saved_recipe():
    user = create_users()[0]
    recipe = create_recipes(user)
    saved = create_saved_recipes(user, recipe)[0]
    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/saved/{saved.id}/'
    response = client.delete(url)

    print(response.status_code)

    assert SavedRecipe.objects.filter(user=user, recipe=recipe[0]).count() == 0        



@pytest.mark.django_db
def test_delete_saved_recipe_when_2_liked():
    user = create_users()[0]
    recipes = create_recipes(user)
        
    saved_recipes = create_saved_recipes(user, recipes)
    
    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/saved/{saved_recipes[0].id}/'
    response = client.delete(url)


    assert SavedRecipe.objects.filter(user=user, recipe=recipes[0]).count() == 0
    assert SavedRecipe.objects.all().count() == len(saved_recipes) - 1


@pytest.mark.django_db
def test_add_saved_recipe():
    user = create_users()[0]

    recipe = create_recipes(user)[0]
    # saved_recipe = SavedRecipe(user=user, recipe=recipe, is_recommendation=True)
    # saved_recipe = SavedRecipe.objects.create(user=user, recipe=recipe, is_recommendation=True)
    client = APIClient()
    client.force_authenticate(user)
    
    url = '/api/recipes/saved/'
    data = {'user': user.id, 'recipe': recipe.id, 'is_recommendation': True}
    response = client.post(url, data)
    assert SavedRecipe.objects.filter(user=user, recipe=recipe).count() == 1
    assert SavedRecipe.objects.all().count() == 1
# @pytest.mark.django_db
# @pytest.mark.django_db
# def test_get_recipes_created_by_user():
#     # Create multiple users
#     user1 = DishDiscoverUser.objects.create(user_id=1, username='user1', email='user1@example.com', password='password1')
#     user2 = DishDiscoverUser.objects.create(user_id=2, username='user2', email='user2@example.com', password='password2')

#     # Create recipes for each user
#     recipe_user1 = Recipe.objects.create(recipe_id=1, author=user1, recipe_name="Recipe by User 1", content="Content 1")
#     recipe_user2 = Recipe.objects.create(recipe_id=2, author=user2, recipe_name="Recipe by User 2", content="Content 2")

#     # Authenticate as user1
#     client = Client()
#     client.force_login(user1)

#     # Call the endpoint associated with created_by_user action
#     url = reverse('get_created_by_user')
#     response = client.get(url)

#     # Check that the response contains the recipe created by user1 and not the one by user2
#     assert response.status_code == 200
#     data = response.json()
#     assert len(data) == 1
#     assert data[0]['recipe_id'] == recipe_user1.recipe_id
#     assert data[0]['author'] == user1.user_id
#     assert data[0]['recipe_name'] == "Recipe by User 1"

#     # Logout to clear the authentication for subsequent tests
#     client.logout()