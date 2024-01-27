from django.http import JsonResponse
from django.shortcuts import get_object_or_404

from recipes.serializers import RecipeSerializer
from .models import *
# from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import *
from rest_framework import viewsets
from rest_framework.decorators import action


class UserViewSet(viewsets.ModelViewSet):
    queryset = DishDiscoverUser.objects.all()
    serializer_class = UserSerializer

    #excluded from router
    #@action(detail=False, methods=['get'], url_path='username', url_name='username')
    def get_user_by_username(self, request, username=None):
        print(username)
        user = get_object_or_404(DishDiscoverUser, username=username)
        serializer = UserSerializer(user)
        return Response(serializer.data)
    
    @action(detail=True, methods=['get'])
    def saved_recipes(self, request, pk=None):
        user = self.get_object()
        saved_recipes = SavedRecipe.objects.filter(user=user)
        serializer = RecipeSerializer(saved_recipes, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['GET'])
    def liked_recipes(self, request, pk=None):
        user = self.get_object()
        liked_recipes = LikedRecipe.objects.filet(user=user)
        serializer = RecipeSerializer(liked_recipes, many=True)
        