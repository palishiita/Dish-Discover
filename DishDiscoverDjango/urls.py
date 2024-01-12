# DishDiscoverDjango/urls.py
from django.urls import path
from .views import *

urlpatterns = [
    path('api/tagcategories/', get_TagCategories, name='get_tagcategories'),
    path('api/tags/', get_Tags, name='get_tags'),
    path('api/users/', get_Users, name='get_users'),
    path('api/preferredtags/', get_PreferredTags, name='get_preferredtags'),
    path('api/comments/', get_Comments, name='get_comments'),
    path('api/savedrecipes/', get_SavedRecipes, name='get_savedrecipes'),
    path('api/likedrecipes/', get_LikedRecipes, name='get_likedrecipes'),
    path('api/ingredients/', get_Ingredients, name='get_ingredients'),
    path('api/recipes/', get_Recipes, name='get_recipes'),
    path('api/recipeingredients/', get_RecipeIngredients, name='get_recipeingredients'),
    path('api/recipetags/', get_RecipeTags, name='get_recipetags'),

    #path('users/', UserList.as_view(), name='user-list'),
    #path('recipes/', RecipeList.as_view(), name='recipe-list'),
]
