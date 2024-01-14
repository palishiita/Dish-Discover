# DishDiscoverDjango/serializers.py
from rest_framework import serializers
from .models import DishDiscoverUser, Recipe  # Fix the import statement

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishDiscoverUser
        fields = '__all__'

class RecipeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recipe  # Fix the model reference
        fields = '__all__'
