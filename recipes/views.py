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
from django.views.decorators.http import require_http_methods


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

    # def get_queryset(self):
    #     # # Get the current user
    #     # if self.action == 'created_by_user':
    #     #     user = self.request.user
    #     #     return Recipe.objects.filter(author=user)

    #     # return super().get_queryset()  # Return the default queryset if not 'created_by_user'
    
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

    @action(detail=True, methods=['GET'])
    def comments (self, request, pk=None):
        recipe = self.get_object()
        recipe_comments = Comment.objects.filter(recipe=recipe)
        serializer = CommentSerializer(recipe_comments, many=True)
        return Response(serializer.data)


class TagViewSet(viewsets.ModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer

class PreferredTagViewSet(viewsets.ModelViewSet):
    serializer_class = PreferredTagSerializer

    def get_queryset(self):
        return PreferredTag.objects.filter(user=self.request.user)

# class RecipeTagViewSet(viewsets.ModelView):
#     serializer_class = RecipeTagSerializer

class LikedRecipeViewSet(viewsets.ModelViewSet):
    serializer_class = LikedRecipeSerializer

    def get_queryset(self):       
        return LikedRecipe.objects.filter(user=self.request.user)

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        return Response(status=status.HTTP_204_NO_CONTENT)

    
class SavedRecipeViewSet(viewsets.ModelViewSet):
    serializer_class = SavedRecipeSerializer
    queryset = SavedRecipe.objects.all()

    
    def get_queryset(self):       
            return SavedRecipe.objects.filter(user=self.request.user)
    
    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        return Response(status=status.HTTP_204_NO_CONTENT)
    # def perform_create(self,serializer):
    #     serializer.save(
    #     user=self.request.user,
    #     recipe=self.kwargs.get('pk'),
    #     )
    

class TagCategoryViewSet(viewsets.ModelViewSet):
    queryset = TagCategory.objects.all()
    serializer_class = TagCategorySerializer


class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer

    @action(detail=False, methods=['GET'], url_name='byuser')
    def by_user(self, request, pk=None):
        user = request.user
        user_comments = Comment.objects.filter(user=user)
        serializer = CommentSerializer(user_comments, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=['GET'], url_path='byrecipe/(?P<recipe_id>\d+)')
    def by_recipe(self, request, recipe_id=None):
        recipe_comments = Comment.objects.filter(recipe_id=recipe_id)
        serializer = CommentSerializer(recipe_comments, many=True)
        return Response(serializer.data)
    

class LikesOnUsersRecipes(viewsets.GenericViewSet):
    @action(detail=True, methods=['GET'])

    def getUserSumLikes(self, request):
        user = request.user
        likes = LikedRecipe.objects.filter(recipe__author = user).count()
        serializer = LikeCountSerializer({'number': likes})
        return Response(serializer.data)

