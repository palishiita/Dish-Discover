# DishDiscoverDjango/serializers.py
from rest_framework import serializers
from .models import User, Recipes  # Fix the import statement

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class RecipeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recipes  # Fix the model reference
        fields = '__all__'
