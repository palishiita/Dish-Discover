from django.http import JsonResponse
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

    @action(detail=True, methods=['get'])
    def saved_recipes(self, request, pk=None):
        user = self.get_object()
        saved_recipes = SavedRecipe.objects.filter(user=user)
        serializer = SavedRecipeSerializer(saved_recipes, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['GET'])
    def liked_recipes(self, request, pk=None):
        user = self.get_object()
        liked_recipes = LikedRecipe.objects.filet(user=user)
        serializer = LikedRecipeSerializer(liked_recipes, many=True)
        