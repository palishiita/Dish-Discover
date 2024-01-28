# DishDiscoverDjango/urls.py
from django.urls import path
from .views import *
from authorisation.views import registration_view
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
router.register(r'ingredients', IngredientViewSet, basename='ingredients')
router.register(r'recipes', RecipeViewSet, basename='recipes')
router.register(r'tagcategories', TagCategoryViewSet, basename='tagcategories')
router.register(r'tags', TagViewSet, basename='tags')
router.register(r'preferredtags', PreferredTagViewSet, basename='preferredtags')
router.register(r'saved', SavedRecipeViewSet, basename='saved')
router.register(r'liked', LikedRecipeViewSet, basename='liked')
router.register(r'tagcategories', TagCategoryViewSet, basename='tagcategories')
router.register(r'tags', TagViewSet, basename='tags')
router.register(r'comments', CommentViewSet, basename='comments')
router.register(r'likes', LikesOnUsersRecipes, basename='likes')
router.register(r'reporttickets', ReportTicketViewSet, basename='reporttickets')


urlpatterns = router.urls

# urlpatterns = [  
#     #TESTED 
#     # INGREDIENTS
#     path('ingredients/', IngredientViewSet.as_view({'get':'list'}), name='get_ingredients'),
#     path('ingredients/<int:pk>/', IngredientViewSet.as_view({'get':'retrieve'}), name='get_ingredients'),
#     #RECIPES    
#     path('', RecipeViewSet.as_view({'get':'list'}), name='get_recipes'),
#     path('<int:pk>/', RecipeViewSet.as_view({'get': 'retrieve'}), name= 'get_recipe'),
#     path('<int:pk>/tags/', RecipeViewSet.as_view({'get':'tags'}), name='get_recipetags'),
#     path('<int:pk>/ingredients/', RecipeViewSet.as_view({'get': 'ingredients'}), name='get_recipeingredients'),
#     path('<int:pk>/comments/', RecipeViewSet.as_view({'get': 'comments'}), name='get_comments'),       


#     # path('byuser', RecipeViewSet.as_view({'get':'created_by_user'}), name='get_created_by_user'),
#     path('saved/', SavedRecipeViewSet.as_view({'get':'list', 'post':'create'}), name='get_savedrecipes'),
#     path('saved/<int:pk>', SavedRecipeViewSet.as_view({'delete':'destroy'}), name = 'delete_saved_recipe'),
#     path('liked/', LikedRecipeViewSet.as_view({'get':'list'}), name='get_liked_recipes'),
#     path('liked/<int:pk>/', LikedRecipeViewSet.as_view({'delete':'destroy'}), name='delete_liked_recipe'),


#     #TAGS
#     path('tagcategories/', TagCategoryViewSet.as_view({'get':'list'}), name='get_tagcategories'),
#     path('tags/', TagViewSet.as_view({'get':'list'}), name='get_tags'),
#     path('tags/preferred/', TagViewSet.as_view({'get':'preferred'}), name='get_preferredtags'),

#     #COMMENTS    
#     path('comments/', CommentViewSet.as_view({'get':'list'}), name='get_comments'),
#     path('comments/byuser/', CommentViewSet.as_view({'get': 'by_user'}), name='comment_by_user'),

#     #LIKES RECIEVED BY USER
#     path('likes/', GetLikesOnUserRecipes.as_view({'get':'getUserSumLikes'}), name='get_likes'),
# ]
