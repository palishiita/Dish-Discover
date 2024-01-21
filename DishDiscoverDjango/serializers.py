# DishDiscoverDjango/serializers.py
from rest_framework import serializers
from .models import *  # Fix the import statement

# class UserSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = DishDiscoverUser
#         fields = '__all__'

class RecipeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recipe  # Fix the model reference
        fields = '__all__'

class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag  # Fix the model reference
        fields = '__all__'
        
class RecipeTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecipeTag
        fields = '__all__'