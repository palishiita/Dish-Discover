import json
from recipes.models import *

### Inputting Recipe and Ingredients to Database ###                

# Read the JSON file



users = [
     DishDiscoverUser.objects.get_or_create(username='Janet_doe', has_mod_rights=True, email='janet@example.com', password='123', is_premium=False)[0],
     DishDiscoverUser.objects.get_or_create(username='Jacob_doe', has_mod_rights=False, email='Jacob@example.com', password='456', is_premium=True)[0]
]

for element in users:
    element.save()

category = TagCategory.objects.get_or_create(category_name='Ingredient')[0]

with open('scraped_recipes.json', 'r') as json_file:
    scraped_recipes = json.load(json_file)

# Create Recipe instances from the JSON data
for recipe_data in scraped_recipes:
    # Extract relevant data from the JSON
    title = recipe_data.get('title', '')
    instructions = recipe_data.get('instructions', '')
    ingredients = recipe_data.get('ingredients', [])

    # Create Recipe instance
    recipe_instance = Recipe.objects.get_or_create(
        author=users[0],
        recipe_name=title,
        content=instructions,
        picture=recipe_data.get('image_path', ''),
        is_boosted=False,  
    )[0]

    # Link Ingredients to the Recipe instance
    for ingredient_name in ingredients:
        # Assuming Ingredient model has a 'name' field
        ingredient = Ingredient.objects.get_or_create(name=ingredient_name, tag=Tag.objects.get_or_create(name=ingredient_name, is_predefined=False, tag_category=category)[0])[0]
        recipe_instance.ingredients.add(ingredient, through_defaults={'amount': 1, 'unit': 'g'})

print("Recipe instances created successfully.")


### Users in database ###




### Liked Recipe for each user ###

# Get the Recipe instances 
liked_recipes_titles = ["Classic Glazed Doughnuts", "Cinnamon Babka", "Creamy Garlic Pasta",
                         "Party Punch IV" ]
liked_recipes = Recipe.objects.filter(recipe_name__in=liked_recipes_titles)

# Add Liked Recipes for janet_doe
for recipe in liked_recipes:
    LikedRecipe.objects.create(user=users[1], recipe=recipe, is_recommendation=False)

print(f"{users[1].username} liked the following recipes:")
for recipe in liked_recipes:
    print(recipe.recipe_name)


### Saved Recipe for each user ###
# Get the Recipe instances 
saved_recipes_titles = ["Scones", "Baked Salmon Fillets Dijon", "Air Fryer Chicken Thighs", 
                        "Baked Haddock", "To Die For Blueberry Muffins", "Simple Garlic Shrimp"]

saved_recipes = Recipe.objects.filter(recipe_name__in=saved_recipes_titles)

# Add Saved Recipes for janet_doe
for recipe in saved_recipes:
    SavedRecipe.objects.create(user=users[1], recipe=recipe, is_recommendation=True)

print(f"{users[1].username} saved the following recipes:")
for recipe in saved_recipes:
    print(recipe.recipe_name)