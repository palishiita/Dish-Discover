# DishDiscoverDjango/serializers.py
from rest_framework import serializers
from .models import *  # Fix the import statement



class RecipeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recipe  # Fix the model reference
        fields = '__all__'

class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag  # Fix the model reference
        fields = '__all__'

class PreferredTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = PreferredTag  # Fix the model reference
        fields = '__all__'
        
class RecipeTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecipeTag
        fields = '__all__'

class TagCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = TagCategory
        fields = '__all__'

class RecipeIngredientSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecipeIngredient
        fields = '__all__'

class IngredientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ingredient
        fields = '__all__'

class SavedRecipeSerializer(serializers.ModelSerializer):
    class Meta:
        model = SavedRecipe
        fields = '__all__'

class LikedRecipeSerializer(serializers.ModelSerializer):
    class Meta:
        model= LikedRecipe
        fields = '__all__'
