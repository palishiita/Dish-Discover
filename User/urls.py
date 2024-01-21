from django.urls import path
from .views import *

urlpatterns = [
    path('users/', UserViewSet.as_view({'get':'list'}), name = 'get_all_users'),
    path('users/<int:pk>/recipes/saved', UserViewSet.as_view({'get':'saved_recipes'}), name = 'get_all_users')
]
