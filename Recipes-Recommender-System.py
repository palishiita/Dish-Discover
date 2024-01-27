# Recipe recommendation system that recommends users recipes based on the liked and saved recipes

import json
import nltk
from gensim.models import Word2Vec
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from recipes.models import DishDiscoverUser, Recipe, LikedRecipe, SavedRecipe

# Download NLTK resources
nltk.download('punkt')

# Load the scraped recipes data
with open('scraped_recipes.json', 'r') as json_file:
    scraped_recipes = json.load(json_file)

# Preprocess and tokenize ingredients
tokenized_ingredients = [nltk.word_tokenize(recipe['ingredients']) for recipe in scraped_recipes]

# Train Word2Vec model
word2vec_model = Word2Vec(sentences=tokenized_ingredients, vector_size=100, window=5, min_count=1, workers=4)

# Average Word Embeddings for each recipe
def average_word_embeddings(ingredients, model):
    embeddings = [model.wv[word] for word in ingredients if word in model.wv]
    return sum(embeddings) / len(embeddings) if embeddings else None

recipe_embeddings = [
    (recipe['title'], average_word_embeddings(nltk.word_tokenize(recipe['ingredients']), word2vec_model))
    for recipe in scraped_recipes
]

# Create a TF-IDF matrix for recipe embeddings
recipe_titles, recipe_vectors = zip(*recipe_embeddings)
tfidf_vectorizer = TfidfVectorizer()
tfidf_matrix = tfidf_vectorizer.fit_transform(recipe_titles)

# Define a function to get recommended recipes
def recommend_recipes(username, num_recommendations=10):
    # Get the DishDiscoverUser instance for the given username
    try:
        user = DishDiscoverUser.objects.get(username=username)
    except DishDiscoverUser.DoesNotExist:
        print(f"User with username {username} not found.")
        return []

    # Get the Recipe instances for liked and saved recipes
    liked_recipes = LikedRecipe.objects.filter(user=user).values_list('recipe__recipe_name', flat=True)
    saved_recipes = SavedRecipe.objects.filter(user=user).values_list('recipe__recipe_name', flat=True)

    # Combine liked and saved recipes
    user_likes = list(liked_recipes)
    user_saves = list(saved_recipes)

    user_liked_embeddings = [average_word_embeddings(nltk.word_tokenize(like), word2vec_model) for like in user_likes]
    user_saved_embeddings = [average_word_embeddings(nltk.word_tokenize(save), word2vec_model) for save in user_saves]

    # Average user's liked and saved embeddings
    avg_user_embedding = sum(user_liked_embeddings + user_saved_embeddings) / (len(user_liked_embeddings) + len(user_saved_embeddings))

    # Transform user's embedding using TF-IDF
    user_tfidf_vector = tfidf_vectorizer.transform([username])
    user_tfidf_embedding = user_tfidf_vector.dot(avg_user_embedding.reshape(1, -1))

    # Calculate cosine similarity between user's embedding and recipe embeddings
    similarities = cosine_similarity(user_tfidf_embedding, recipe_vectors)

    # Get top recommended recipes
    recommended_indices = similarities.argsort()[0][::-1][:num_recommendations]
    recommended_recipes = [recipe_titles[i] for i in recommended_indices]

    return recommended_recipes

# Example usage:
username = "Janet_doe"
recommended_recipes = recommend_recipes(username)
print(f"Recommended Recipes for {username}:")
for recipe in recommended_recipes:
    print(recipe)