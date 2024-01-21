from django.urls import path
from authorisation.views import *


urlpatterns = [
    path('register', registration_view, name="register")
]