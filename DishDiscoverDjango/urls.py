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
    path('', RecipeViewSet.as_view({'get':'list'}), name='get_recipes'),
    path('<int:pk>/', RecipeViewSet.as_view({'get': 'retrieve'}), name= 'get_recipe'),
    path('<int:pk>/tags/', RecipeViewSet.as_view({'get':'tags'}), name='get_recipetags'),
    path('<int:pk>/ingredients/', RecipeViewSet.as_view({'get': 'ingredients'}), name='get_recipeingredients'),
    path('<int:pk>/comments/', RecipeViewSet.as_view({'get': 'comments'}), name='get_comments'),    
    

    path('saved/', RecipeViewSet.as_view({'get':'saved'}), name='get_savedrecipes'),
    path('liked/', RecipeViewSet.as_view({'get':'liked'}), name='get_liked_recipes'),


    #TAGS
    path('tagcategories/', TagCategoryViewSet.as_view({'get':'list'}), name='get_tagcategories'),
    path('tags/', TagViewSet.as_view({'get':'list'}), name='get_tags'),
    path('tags/preferred/', TagViewSet.as_view({'get':'preferred'}), name='get_preferredtags'),

    #COMMENTS    
    path('comments/', CommentViewSet.as_view({'get':'list'}), name='get_comments'),
    path('comments/byuser/', CommentViewSet.as_view({'get': 'by_user'}), name='comment_by_user')

  
]
