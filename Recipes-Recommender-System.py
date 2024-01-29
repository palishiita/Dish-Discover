# Recipe recommendation system that recommends users recipes based on the liked and saved recipes

import os
from django import setup
from django.shortcuts import get_object_or_404
from recipes.models import *
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

# Set the Django settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'DishDiscover.settings')
setup()

def recommend_recipes(username, top_n=10):
    # Retrieve user object
    user = get_object_or_404(DishDiscoverUser, username=username)
    
    # Retrieve all liked and saved recipes of the user
    liked_recipes = user.likedrecipe_set.all().values_list('recipe__id', flat=True)
    saved_recipes = user.savedrecipe_set.all().values_list('recipe__id', flat=True)
    user_recipes = list(liked_recipes) + list(saved_recipes)
    
    # Extract features from recipes (title, description, ingredient names)
    all_recipes = Recipe.objects.all()
    
    # Get titles and descriptions
    recipe_titles = [recipe.recipe_name for recipe in all_recipes]
    recipe_descriptions = [recipe.description for recipe in all_recipes]
    
    # Get ingredient names
    ingredient_names = []
    for recipe in all_recipes:
        ingredients = recipe.recipeingredient_set.all()
        ingredient_names.append(' '.join([ingredient.ingredient.name for ingredient in ingredients]))
    
    # Combine titles, descriptions, and ingredient names
    recipe_texts = [f"{title} {description} {ingredients}" 
                    for title, description, ingredients in zip(recipe_titles, recipe_descriptions, ingredient_names)]
    
    # TF-IDF vectorization
    vectorizer = TfidfVectorizer()
    tfidf_matrix = vectorizer.fit_transform(recipe_texts)
    
    # Compute cosine similarity between user's recipes and all recipes
    similarity_scores = cosine_similarity(tfidf_matrix[user_recipes, :], tfidf_matrix)
    
    # Sort recipes based on similarity scores
    similar_recipes_indices = similarity_scores.argsort(axis=1)[:, ::-1]
    
    # Get top N recommended recipes
    recommended_recipe_ids = [similar_recipes_indices[i, 1:top_n+1] for i in range(len(user_recipes))]
    recommended_recipes = [Recipe.objects.filter(id__in=ids) for ids in recommended_recipe_ids]
    
    # Remove liked and saved recipes from recommended recipes
    for i, user_recipe in enumerate(user_recipes):
        recommended_recipes[i] = recommended_recipes[i].exclude(id__in=[str(id) for id in user_recipes])
    
    return recommended_recipes


# Testing: Print titles of the recommended recipes for a user
try:
    user = DishDiscoverUser.objects.get(username='jane_doe2')
    #user = DishDiscoverUser.objects.get(username='john_doe2')
    print(f"User found: {user.username}")
except DishDiscoverUser.DoesNotExist:
    print("User not found.")

# Call the function with the user instance
recommendations = recommend_recipes(user)
print("Recommendations for User:", user)
for recipe in recommendations[0]:
    print(f"- {recipe.recipe_name}")





# def print_all_recipes():
#     # Get all recipes from the database
#     all_recipes = Recipe.objects.all()

#     # Print details of each recipe
#     for recipe in all_recipes:
#         print(f"Recipe ID: {recipe.id}")
#         print(f"Name: {recipe.recipe_name}")
#         print(f"Author: {recipe.author.username}")
#         print(f"Description: {recipe.description}")
#         print("\nIngredients:")
        
#         # Print ingredients for the recipe
#         for recipe_ingredient in recipe.recipeingredient_set.all():
#             print(f"- {recipe_ingredient.amount} {recipe_ingredient.unit} {recipe_ingredient.ingredient.name}")

#         print("\nTags:")
        
#         # Print tags for the recipe
#         for recipe_tag in recipe.recipetag_set.all():
#             print(f"- {recipe_tag.tag.name}")

#         print("\n------------------------\n")

# # Call the function to print all recipes
# print_all_recipes()
