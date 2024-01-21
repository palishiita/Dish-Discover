from rest_framework import serializers
from DishDiscoverDjango.models import *
from rest_framework.decorators import api_view

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishDiscoverUser
        fields = '__all__'

class SavedRecipeSerializer(serializers.ModelSerializer):
    class Meta:
        model = SavedRecipe
        fields = '__all__'

class LikedRecipeSerializer(serializers.ModelSerializer):
    model= LikedRecipe
    fields = '__all__'
