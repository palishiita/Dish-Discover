from rest_framework import serializers
from recipes.models import *
from rest_framework.decorators import api_view

from recipes.serializers import CommentSerializer, LikedRecipeSerializer, RecipeSerializer, SavedRecipeSerializer

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishDiscoverUser
        fields = '__all__'

class combinedUserSerializer(serializers.Serializer):
    user = UserSerializer(many=False)
    recipes = RecipeSerializer(many=True)
    comments = CommentSerializer(many=True)

