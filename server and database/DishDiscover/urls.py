# recipe_project/urls.py
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/auth/', include('authorisation.urls')),  # Change 'recipes' to 'recipes'
    path('api/recipes/', include('recipes.urls')),
    path('api/user/', include('User.urls')),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

