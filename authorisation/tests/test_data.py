from django.test import Client
from django.urls import reverse
from recipes.models import *
import json
import pytest 
from rest_framework.test import APIClient


def create_users():
    return [
        DishDiscoverUser.objects.create(id = 10, username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False),
        DishDiscoverUser.objects.create(id = 11, username='mickey2_mouse', has_mod_rights=False, email='mickey@example.com', password='password123', is_premium=False),
        DishDiscoverUser.objects.create(id = 12, username='naughty_mouse', has_mod_rights=False, email='mickey@example.com', password='password123', is_premium=False)

        ]

def create_recipes(user):
    return [
        Recipe.objects.create(
            id=10,
            author=user,
            recipe_name="Test Recipe",
            content="Test content",
            description="Test description",
            is_boosted=False
        ) 
    ]

def create_comments(user, recipe):
    return [
        Comment.objects.create(id = 10,user=user, recipe=recipe, content='This chocolate cake is amazing!'),
        Comment.objects.create(id = 11,user=user, recipe=recipe, content='I love spaghetti bolognese!')
    ]

def create_comments_list(user, recipes):
    return [
        Comment.objects.create(id = 10+i,user=user, recipe=recipe, content='This chocolate cake is amazing!') for i, recipe in enumerate(recipes,start=1)
        #Comment.objects.create(id = 11,user=user, recipe=recipe, content='I love spaghetti bolognese!')
    ]


def valid_login_data():
    return [{
        'username': 'testuser',
        'email': 'test@example.com',
        'password': 'testpassword',
        'password2': 'testpassword',
    }]

def create_tagcategories():
    return [
        TagCategory.objects.create(category_name='Cousine'),
        TagCategory.objects.create(category_name='Diet'),
        TagCategory.objects.create(category_name='Type of meal'),
        TagCategory.objects.create(category_name='Dish type'),
        TagCategory.objects.create(category_name='Ingredient type'),
        TagCategory.objects.create(category_name='Ingredient')
    ]

def create_tags(tagcategories):
    return [
        Tag.objects.create(name=f'Polish{tag_category.category_name}',tag_category=tag_category,is_predefined = True) for tag_category in tagcategories
    ]

def create_notpredef_tags(tagcategories):
    return [
        Tag.objects.create(name=f'Polish{tag_category.category_name}',tag_category=tag_category,is_predefined = False) for tag_category in tagcategories
    ]
    
def create_ingredients(tags):
    return [
        Ingredient.objects.create(id=i, name=f'Avocado{tag.name}', calorie_density=50.0, tag=tag)
        for i, tag in enumerate(tags, start=10)
    ]

def create_recipe_ingredients(ingredients, recipe):
    return [
        RecipeIngredient.objects.create(recipe=recipe, ingredient= ingredient, amount=200.0, unit='g') for ingredient in ingredients
    ]

def create_recipe_ingredients_list(ingredients, recipes):
    return [
        RecipeIngredient.objects.create(recipe=recipe, ingredient= ingredient, amount=200.0, unit='g') for ingredient in ingredients for recipe in recipes
    ]

def create_preferred_tags(user, tags):
    return [
        PreferredTag.objects.create(user=user, tag=tag, weight=0.8) for tag in tags
    ]

def create_recipe_tags_list(tags, recipes):
    return [
        RecipeTag.objects.create(recipe=recipe, tag=tag, weight=0.8) for tag in tags for recipe in recipes
    ]

def create_liked_recipes(user, recipes):
    return [
        LikedRecipe.objects.create(user=user, recipe=recipe, is_recommendation=False) for recipe in recipes
    ]

def create_saved_recipes(user, recipes):
    return [
        SavedRecipe.objects.create(user=user, recipe=recipe, is_recommendation=False) for recipe in recipes
    ]


def create_report_tickets(user, recipes):
    return [
        ReportTicket.objects.create(id = 10, recipe=recipe, violator=user, issuer=user, comment=None, reason='This recipe is inappropriate') for recipe in recipes
    ]

def create_report_tickets2(user, violator, recipes):
    return [
        ReportTicket.objects.create(id = 10, recipe=recipe, violator=violator, issuer=user, comment=None, reason='This recipe is inappropriate') for recipe in recipes
    ]