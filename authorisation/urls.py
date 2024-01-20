from django.urls import path
from authorisation.views import (
    registration_view,
)


urlpatterns = [
    path('register', registration_view, name="register")
]