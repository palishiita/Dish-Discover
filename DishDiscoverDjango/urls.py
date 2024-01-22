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


    # path('byuser', RecipeViewSet.as_view({'get':'created_by_user'}), name='get_created_by_user'),
    path('saved/', SavedRecipeViewSet.as_view({'get':'list'}), name='get_savedrecipes'),
    path('saved/<int:pk>', SavedRecipeViewSet.as_view({'delete':'destroy'}), name = 'delete_saved_recipe'),
    path('liked/', LikedRecipeViewSet.as_view({'get':'list'}), name='get_liked_recipes'),
    path('liked/<int:pk>/', LikedRecipeViewSet.as_view({'delete':'destroy'}), name='delete_liked_recipe'),




    #TAGS
    path('tagcategories/', TagCategoryViewSet.as_view({'get':'list'}), name='get_tagcategories'),
    path('tags/', TagViewSet.as_view({'get':'list'}), name='get_tags'),
    path('tags/preferred/', TagViewSet.as_view({'get':'preferred'}), name='get_preferredtags'),

    #COMMENTS    
    path('comments/', CommentViewSet.as_view({'get':'list'}), name='get_comments'),
    path('comments/byuser/', CommentViewSet.as_view({'get': 'by_user'}), name='comment_by_user')

  
]
