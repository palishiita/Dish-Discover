# recipe_project/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/auth/', include('authorisation.urls')),  # Change 'recipes' to 'DishDiscoverDjango'
    path('api/recipes/', include('DishDiscoverDjango.urls')),
]
