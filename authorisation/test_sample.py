# myapp/tests.py
from django.test import Client
from django.urls import reverse
from DishDiscoverDjango.models import *
import json
import pytest 
from rest_framework.test import APIClient


def create_user():
    return DishDiscoverUser.objects.create(username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    
@pytest.mark.django_db

def test_get_recipe_view():
    user = create_user()
    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )

    client = Client()

    # Build the URL for the view with the recipe ID
    url = f'/api/recipes/recipes/{recipe.recipe_id}/'

    response = client.get(url)

    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'

    data = json.loads(response.content)

    # Adjust assertions based on the structure of your serialized data
    assert 'recipe_id' in data
    assert 'author' in data
    assert 'recipe_name' in data

    # Add more assertions for other fields as needed
    assert data['recipe_id'] == recipe.recipe_id
    assert data['author'] == recipe.author.user_id
    assert data['recipe_name'] == recipe.recipe_name
    # Add more assertions for other fields as needed

@pytest.mark.django_db
def test_get_recipe_tags():
    client =Client()
    tagCategories = [
        TagCategory(category_name='Cousine'),
        TagCategory(category_name='Difficulty'),
        TagCategory(category_name='Ingredient'),
        TagCategory(category_name='Other')
        ]
    user = create_user()
    tags = [
        Tag(name='Polish',tag_category=tagCategories[0],is_predefined = True),
        Tag(name='Easy',tag_category=tagCategories[1],is_predefined = True),
        Tag(name='Tomato',tag_category=tagCategories[2],is_predefined = True),
        Tag(name='Avocado',tag_category=tagCategories[2],is_predefined = True)
        ]
    
    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )

    recipeTags = [
        RecipeTag(recipe=recipe, tag=tags[0], weight=0.8),
        RecipeTag(recipe=recipe, tag=tags[1], weight=0.5),
        RecipeTag(recipe=recipe, tag=tags[2], weight=0.9),
    ]

    url = f'/api/recipes/recipes/{recipe.recipe_id}/tags/'
    response = client.get(url)
    assert response.status_code == 200

@pytest.mark.django_db
def test_get_recipe_ingredients():
    user = create_user()
    recipe = Recipe.objects.create(
        recipe_id=10,
        author_id=user.id,
        recipe_name="Test Recipe",
        content="Test content",
        description="Test description",
        is_boosted=False
    )

    recipeIngredients = [
    RecipeIngredient(recipe=recipe, ingredient= Ingredient(name='Tomato', calorie_density=20.0), amount=200.0, unit='g'),
    RecipeIngredient(recipe=recipe, ingredient=Ingredient(name='Avocado', calorie_density=50.0), amount=250.0, unit='g')
    ]

    client = Client()
    url = f'api/recipes/recipes/{recipe.recipe_id}/ingredients/'
    response = client.get(url)
    assert response.status_code




@pytest.mark.django_db
def test_get_all_recipes():
    
    client = APIClient()

    # Build the URL for the view with the recipe ID
    url = f'/api/recipes/recipes/'
    user = User.objects.create_user(username='testuser', password='123')
    client.force_authenticate(user)
    response = client.get(url)
    assert response.status_code == 200
    assert response['Content-Type'] == 'application/json'

    data = json.loads(response.content)


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

    assert response.status_code == 200, response.json()



@pytest.mark.django_db
def test_get_all_tags():

    tags = [
        Tag(name='Polish',is_predefined = True),
        Tag(name='Easy',is_predefined = True),
        Tag(name='Tomato',is_predefined = True),
        Tag(name='Avocado',is_predefined = True)
        ]
    user = DishDiscoverUser.objects.create(username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    client = Client()
    url = f'/api/recipes/tags/'
    response = client.get(url)
    assert response.status_code == 200

## TEST INGREDIENS

@pytest.mark.django_db
def test_get_all_ingredients():
    user =  DishDiscoverUser.objects.create(username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False)
    client = Client()
    url = f'/api/recipes/ingredients/'
    response = client.get(url)
    assert response.status_code == 200

@pytest.mark.django_db
def test_get_ingredient():
    tagCategory =  TagCategory.objects.create(category_name='Cousine')
    tag = Tag.objects.create(name='Polish',tag_category=tagCategory,is_predefined = True)
    ingredient = Ingredient.objects.create(ingredient_id=10, name='Tomato', calorie_density=20.0, tag=tag)

    client = Client()
    url = f'/api/recipes/ingredients/{ingredient.ingredient_id}/'
    response = client.get(url)

    assert response.status_code == 200, response.json()


@pytest.mark.django_db
def test_registration():
    client = APIClient()

    # Prepare data for a valid registration
    valid_data = {
        'username': 'testuser',
        'email': 'test@example.com',
        'password': 'testpassword',
    }

    url = '/api/auth/register'

    # Make a POST request to the registration view
    response = client.post(url, valid_data)

    # Check if the response status code is 200 (OK)
    assert response.status_code == 200


    # Check if the serializer is val

