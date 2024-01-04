# DishDiscoverDjango/urls.py
from django.urls import path
from .views import UserList, RecipeList

urlpatterns = [
    path('users/', UserList.as_view(), name='user-list'),
    path('recipes/', RecipeList.as_view(), name='recipe-list'),
]
