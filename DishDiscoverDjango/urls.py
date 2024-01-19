# DishDiscoverDjango/urls.py
from django.urls import path
from .views import *

urlpatterns = [
    path('register/', RegistrationView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('tagcategories/', get_TagCategories, name='get_tagcategories'),
    path('tags/', get_Tags, name='get_tags'),
    path('users/', get_Users, name='get_users'),
    path('preferredtags/', get_PreferredTags, name='get_preferredtags'),
    path('comments/', get_Comments, name='get_comments'),
    path('savedrecipes/', get_SavedRecipes, name='get_savedrecipes'),
    path('likedrecipes/', get_LikedRecipes, name='get_likedrecipes'),
    path('ingredients/', get_Ingredients, name='get_ingredients'),
    path('recipes/', get_Recipes, name='get_recipes'),
    path('recipeingredients/', get_RecipeIngredients, name='get_recipeingredients'),
    path('recipetags/', get_RecipeTags, name='get_ recipetags'),
    path('recipe/<id>/', get_Recipe, name= 'get_recipe'),

    #path('users/', UserList.as_view(), name='user-list'),
    #path('recipes/', RecipeList.as_view(), name='recipe-list'),
]
