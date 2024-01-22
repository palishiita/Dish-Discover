# DishDiscoverDjango/urls.py
from django.urls import path
from .views import *
from authorisation.views import registration_view

urlpatterns = [  
    #TESTED 
    # INGREDIENTS
    path('ingredients/', IngredientViewSet.as_view({'get':'list'}), name='get_ingredients'),
    path('ingredients/<int:pk>/', IngredientViewSet.as_view({'get':'retrieve'}), name='get_ingredients'),
    #RECIPES    
    path('recipes/', RecipeViewSet.as_view({'get':'list'}), name='get_recipes'),
    path('recipes/<int:pk>/tags/', RecipeViewSet.as_view({'get':'tags'}), name='get_ recipetags'),
    path('recipes/<int:pk>/ingredients/', RecipeViewSet.as_view({'get': 'ingredients'}), name='get_recipeingredients'),  
    path('recipes/<int:pk>/', RecipeViewSet.as_view({'get': 'retrieve'}), name= 'get _recipe'),

    path('recipes/saved/', RecipeViewSet.as_view({'get':'saved'}), name='get_savedrecipes'),
    path('recipes/liked/', RecipeViewSet.as_view({'get':'liked'}), name='get_liked_recipes'),

    #TAGS
    path('tagcategories/', TagCategoryViewSet.as_view({'get':'list'}), name='get_tagcategories'),
    path('tags/', TagViewSet.as_view({'get':'list'}), name='get_tags'),
    path('tags/preferred/', TagViewSet.as_view({'get':'preferred'}), name='get_preferredtags'),

    #COMMENTS    
    path('comments/', CommentViewSet.as_view({'get':'list'}), name='get_comments'),
    path('comments/byuser/', CommentViewSet.as_view({'get': 'by_user'}), name='comment-by-user')

  
]
