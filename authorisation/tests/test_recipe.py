# myapp/tests.py
from django.test import Client
from django.urls import reverse
from DishDiscoverDjango.models import *
import json
import pytest 
from rest_framework.test import APIClient


def create_user():
    return DishDiscoverUser.objects.create(user_id = 3, username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    
# RECIPE TESTS 

# ALL RECIPES
@pytest.mark.django_db
def test_get_all_recipes():
    
    client = APIClient()

    # Build the URL for the view with the recipe ID
    url = f'/api/recipes/recipes/'
    user = create_user()

    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.user_id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )

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
    user = create_user()
    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.user_id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )

    client = Client()

    # Build the URL for the view with the recipe ID
    url = f'/api/recipes/recipes/{recipe.recipe_id}/'

    response = client.get(url)
    data = json.loads(response.content)

    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'
    assert 'recipe_id' in data
    assert 'author' in data
    assert 'recipe_name' in data
    assert data['recipe_id'] == recipe.recipe_id
    assert data['author'] == recipe.author.user_id
    assert data['recipe_name'] == recipe.recipe_name


# LIKED RECIPES
@pytest.mark.django_db
def test_get_liked_recipes():
    user = DishDiscoverUser.objects.create(user_id =10, username='mickey_mouse', has_mod_rights=False, email='mickey@example.com', password='password123', is_premium=False)
    recipe = Recipe.objects.create(
        recipe_id=10,
        author=user,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )
    LikedRecipe.objects.create(user=user, recipe=recipe, is_recommendation=True),
    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/recipes/liked/'
    response = client.get(url)
    data = response.json()

    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'
    for item in data:
        assert 'id' in item, response.json()
        assert 'recipe' in item, response.json()
        assert 'user' in item, response.json()


# SAVED RECIPES
@pytest.mark.django_db
def test_get_saved_recipes():
    user = DishDiscoverUser.objects.create(user_id =10, username='mickey_mouse', has_mod_rights=False, email='mickey@example.com', password='password123', is_premium=False)
    recipe = Recipe.objects.create(
        recipe_id=10,
        author=user,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )
    SavedRecipe.objects.create(user=user, recipe=recipe, is_recommendation=True),
    client = APIClient(user)
    client.force_authenticate(user)
    url = f'/api/recipes/recipes/saved/'
    response = client.get(url)
    data = response.json()

    assert response.status_code == 200, response.json()
    assert response['Content-Type'] == 'application/json'
    for item in data:
        assert 'id' in item, response.json()
        assert 'recipe' in item, response.json()
        assert 'user' in item, response.json()

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
    url = f'/api/recipes/recipes/{recipe.recipe_id}/ingredients/'
    response = client.get(url)
    data = response.json()
    
    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'
    for item in data:
        assert 'amount' in item, response.json()







# from rest_framework.authtoken.models import Token

# @pytest.mark.django_db
# def test_registration():
#     client = APIClient()

#     # Prepare data for a valid registration
#     valid_data = {
#         'username': 'testuser',
#         'email': 'test@example.com',
#         'password': 'testpassword',
#         'password2': 'testpassword',
#     }

#     url = '/api/auth/register'
#     response = client.post(url, valid_data)


#     assert response.status_code == 200, response.json()
#     assert DishDiscoverUser.objects.filter(email="test@example.com").count() == 1
  