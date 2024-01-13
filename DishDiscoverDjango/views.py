from django.http import JsonResponse
from .models import *

def get_TagCategories(request):
    categories = TagCategory.objects.all()
    data = [{'category_name': category.category_name} for category in categories]
    return JsonResponse({'categories': data})

def get_Tags(request):
    tags = Tag.objects.all()
    data = [{'name': tag.name, 'tag_category': tag.tag_category.category_name, 'is_predefined': tag.is_predefined} for tag in tags]
    return JsonResponse({'tags': data})

def get_Users(request):
    users = User.objects.all()
    data = [{'user_id': user.user_id, 'username': user.username, 'has_mod_rights': user.has_mod_rights, 'email': user.email, 'password': user.password, 'picture': user.picture, 'description': user.description, 'is_premium': user.is_premium, 'unban_date': user.unban_date} for user in users]
    return JsonResponse({'users': data})

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

def get_LikedRecipes(request):
    likedrecipes = LikedRecipe.objects.all()
    data = [{'user': likedrecipe.user.user_id, 'recipe': likedrecipe.recipe.recipe_id, 'is_recommendation': likedrecipe.is_recommendation} for likedrecipe in likedrecipes]
    return JsonResponse({'likedrecipes': data})

def get_Ingredients(request):
    ingredients = Ingredient.objects.all()
    data = [{'ingredient_id': ingredient.ingredient_id, 'name': ingredient.name, 'calorie_density': ingredient.calorie_density} for ingredient in ingredients]
    return JsonResponse({'ingredients': data})

def get_Recipes(request):
    recipes = Recipe.objects.all()
    data = [{'recipe_id': recipe.recipe_id, 'author': recipe.author.user_id, 'recipe_name': recipe.recipe_name, 'content': recipe.content, 'picture': recipe.picture, 'description': recipe.description, 'is_boosted': recipe.is_boosted} for recipe in recipes]
    return JsonResponse({'recipes': data})

def get_RecipeIngredients(request):
    recipeingredients = RecipeIngredient.objects.all()
    data = [{'recipe': recipeingredient.recipe.recipe_id, 'ingredient': recipeingredient.ingredient.ingredient_id, 'quantity': recipeingredient.quantity, 'unit': recipeingredient.unit} for recipeingredient in recipeingredients]
    return JsonResponse({'recipeingredients': data})

def get_RecipeTags(request):
    recipetags = RecipeTag.objects.all()
    data = [{'recipe': recipetag.recipe.recipe_id, 'tag': recipetag.tag.name} for recipetag in recipetags]
    return JsonResponse({'recipetags': data})

