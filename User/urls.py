from django.urls import path
from .views import *

urlpatterns = [
    path('users/', UserViewSet.as_view({'get':'list'}), name = 'get_all_users'),
    path('<int:pk>/recipes/saved/', UserViewSet.as_view({'get':'saved_recipes'}), name = 'get_saved_recipes'),
    path('<int:pk>/recipes/liked/', UserViewSet.as_view({'get':'saved_recipes'}), name = 'get_liked_recipes')
]
