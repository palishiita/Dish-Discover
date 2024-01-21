# DishDiscoverDjango/urls.py
from django.urls import path
from .views import *
from authorisation.views import registration_view

urlpatterns = [
    # path('register/', registration_view, name='register'),
    # path('login/', LoginView.as_view(), name='login'),
    path('tagcategories/', get_TagCategories, name='get_tagcategories'),
    path('tags/', TagsViewSet.as_view({'get':'list'}), name='get_tags'),
    path('tags/preferred', get_PreferredTags, name='get_preferredtags'),
    path('comments/', get_Comments, name='get_comments'), 
    path('ingredients/', IngredientViewSet.as_view({'get':'list'}), name='get_ingredients'),
    path('ingredients/<int:pk>/', IngredientViewSet.as_view({'get':'retrieve'}), name='get_ingredients'),
    ##RECIPES
    path('recipes/saved/', get_SavedRecipes, name='get_savedrecipes'),
    path('recipes/liked/', RecipeViewSet.as_view({'get':'liked'}), name='get_liked_recipes'),
    
    path('recipes/', RecipeViewSet.as_view({'get':'list'}), name='get_recipes'),
    path('recipes/<int:pk>/tags/', RecipeViewSet.as_view({'get':'tags'}), name='get_ recipetags'),
    path('recipes/<int:pk>/ingredients/', RecipeViewSet.as_view({'get': 'ingredients'}), name='get_recipeingredients'),  
    # path('recipes/<id>/', get_Recipe, name= 'get_recipe'),
    path('recipes/<int:pk>/', RecipeViewSet.as_view({'get': 'retrieve'}), name= 'get _recipe'),
    #path('users/', UserList.as_view(), name='user-list'),
    #path('recipes/', RecipeList.as_view(), name='recipe-list'),
]
