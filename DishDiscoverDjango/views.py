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



# class RegistrationView(APIView):
#     def post(self, request):
#         serializer = UserSerializer(data=request.data)
#         if serializer.is_valid():
#             user = serializer.save()
#             Token.objects.create(user=user)
#             return Response({'token': user.auth_token.key}, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# class LoginView(APIView):
#     def post(self, request):
#         username = request.data.get('username')
#         password = request.data.get('password')
#         user = authenticate(request, username=username, password=password)

#         if user:
#             token, created = Token.objects.get_or_create(user=user)
#             return Response({'token': token.key}, status=status.HTTP_200_OK)

#         return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)


class IngredientViewSet(viewsets.ModelViewSet):
    queryset = Ingredient.objects.all()
    serializer_class =IngredientSerializer


class RecipeViewSet(viewsets.ModelViewSet):
    queryset = Recipe.objects.all()
    serializer_class = RecipeSerializer

    @action(detail=True, methods=['get'])
    def tags(self, request, pk=None):
        recipe = self.get_object()
        recipe_tags = RecipeTag.objects.filter(recipe=recipe)
        serializer = RecipeTagSerializer(recipe_tags, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'])
    def ingredients (self, request, pk=None):
        recipe = self.get_object()
        recipe_ingredients = RecipeIngredient.objects.filter(recipe=recipe)
        serializer = RecipeIngredientSerializer(recipe_ingredients, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'])
    def  liked (self, request, pk=None):
       user = request.user
       liked_recipes = LikedRecipe.objects.filter(user=user)
       serializer = LikedRecipeSerializer(liked_recipes, many = True)
       return Response(serializer.data)

    @action(detail=True, methods=['get'])
    def  saved (self, request, pk=None):
       user = request.user
       liked_recipes = SavedRecipe.objects.filter(user=user)
       serializer = SavedRecipeSerializer(liked_recipes, many = True)
       return Response(serializer.data)
    
    @action(detail=True, methods=['GET'])
    def comments (self, request, pk=None):
        recipe = self.get_object()
        recipe_comments = Comment.objects.filter(recipe=recipe)
        serializer = CommentSerializer(recipe_comments, many=True)
        return Response(serializer.data)


class TagViewSet(viewsets.ModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer

    @action(detail=True, methods=['get'])
    def preferred (self, request, pk=None):
       user = request.user
       preferred_tags = PreferredTag.objects.filter(user=user)
       serializer = PreferredTagSerializer(preferred_tags, many = True)
       return Response(serializer.data)




class TagCategoryViewSet(viewsets.ModelViewSet):
    queryset = TagCategory.objects.all()
    serializer_class = TagCategorySerializer


class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer

    @action(detail=True, methods=['GET'])
    def by_user(self, request, pk=None):
        user = request.user
        user_comments = Comment.objects.filter(user=user)
        serializer = CommentSerializer(user_comments, many = True)
        return Response(serializer.data)



