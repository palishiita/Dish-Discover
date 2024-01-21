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



def get_TagCategories(request):
    categories = TagCategory.objects.all()
    data = [{'category_name': category.category_name} for category in categories]
    return JsonResponse({'categories': data})

def get_PreferredTags(request):
    preferredtags = PreferredTag.objects.all()
    data = [{'user': preferredtag.user.user_id, 'tag': preferredtag.tag.name, 'weight': preferredtag.weight} for preferredtag in preferredtags]
    return JsonResponse({'preferredtags': data})

def get_Comments(request):
    comments = Comment.objects.all()
    data = [{'comment_id': comment.comment_id, 'user': comment.user.user_id, 'recipe': comment.recipe.recipe_id, 'content': comment.content} for comment in comments]
    return JsonResponse({'comments': data})

def get_SavedRecipes(request):
    savedrecipes = SavedRecipe.objects.all()
    data = [{'user': savedrecipe.user.user_id, 'recipe': savedrecipe.recipe.recipe_id, 'is_recommendation': savedrecipe.is_recommendation} for savedrecipe in savedrecipes]
    return JsonResponse({'savedrecipes': data})


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

class TagsViewSet(viewsets.ModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer


