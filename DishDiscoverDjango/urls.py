# DishDiscoverDjango/urls.py
from django.urls import path
from .views import *
from authorisation.views import registration_view

urlpatterns = [
    # path('register/', registration_view, name='register'),
    # path('login/', LoginView.as_view(), name='login'),
    path('tagcategories/', get_TagCategories, name='get_tagcategories'),
    path('tags/', TagsViewSet.as_view({'get':'list'}), name='get_tags'),
    path('users/', get_Users, name='get_users'),
    path('tags/preferred', get_PreferredTags, name='get_preferredtags'),
    path('comments/', get_Comments, name='get_comments'),
    path('recipes/saved/', get_SavedRecipes, name='get_savedrecipes'),
    path('recipes/liked/', get_LikedRecipes, name='get_likedrecipes'),
    path('ingredients/', get_Ingredients, name='get_ingredients'),
    path('recipes/', RecipeViewSet.as_view({'get':'list'}), name='get_recipes'),
    #TODO: eeee?
    path('recipes/<id>/tags/', get_RecipeTags, name='get_ recipetags'),
    path('recipes/<id>/ingredients/', get_RecipeIngredients, name='get_recipeingredients'),    
    # path('recipes/<id>/', get_Recipe, name= 'get_recipe'),
    path('recipes/<int:pk>/', RecipeViewSet.as_view({'get': 'retrieve'}), name= 'get_recipe'),


    #path('users/', UserList.as_view(), name='user-list'),
    #path('recipes/', RecipeList.as_view(), name='recipe-list'),
]
