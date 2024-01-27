import json
from recipes.models import Recipe, Ingredient, DishDiscoverUser, LikedRecipe, SavedRecipe

### Inputting Recipe and Ingredients to Database ###                

# Read the JSON file
with open('scraped_recipes.json', 'r') as json_file:
    scraped_recipes = json.load(json_file)

# Create Recipe instances from the JSON data
for recipe_data in scraped_recipes:
    # Extract relevant data from the JSON
    title = recipe_data.get('title', '')
    instructions = recipe_data.get('instructions', '')
    ingredients = recipe_data.get('ingredients', [])

    # Create Recipe instance
    recipe_instance = Recipe.objects.create(
        recipe_name=title,
        content=instructions,
        picture=recipe_data.get('image_path', ''),
        is_boosted=False,  
    )

    # Link Ingredients to the Recipe instance
    for ingredient_name in ingredients:
        # Assuming Ingredient model has a 'name' field
        ingredient, created = Ingredient.objects.get_or_create(name=ingredient_name)
        recipe_instance.ingredients.add(ingredient)

print("Recipe instances created successfully.")


### Users in database ###
users = [
     DishDiscoverUser(username='Janet_doe', has_mod_rights=True, email='janet@example.com', password='123', is_premium=False),
     DishDiscoverUser(username='Jacob_doe', has_mod_rights=False, email='Jacob@example.com', password='456', is_premium=True)
]

for element in users:
    print(element)
    element.save()

users = DishDiscoverUser.objects.all()

# Get the DishDiscoverUser instance for janet_doe
janet_doe = DishDiscoverUser.objects.get(username='janet_doe')

### Liked Recipe for each user ###

# Get the Recipe instances 
liked_recipes_titles = ["Classic Glazed Doughnuts", "Cinnamon Babka", "Creamy Garlic Pasta",
                         "Party Punch IV" ]
liked_recipes = Recipe.objects.filter(recipe_name__in=liked_recipes_titles)

# Add Liked Recipes for janet_doe
for recipe in liked_recipes:
    LikedRecipe.objects.create(user=janet_doe, recipe=recipe, is_recommendation=False)

print(f"{janet_doe.username} liked the following recipes:")
for recipe in liked_recipes:
    print(recipe.recipe_name)


### Saved Recipe for each user ###
# Get the Recipe instances 
saved_recipes_titles = ["Scones", "Baked Salmon Fillets Dijon", "Air Fryer Chicken Thighs", 
                        "Baked Haddock", "To Die For Blueberry Muffins", "Simple Garlic Shrimp"]

saved_recipes = Recipe.objects.filter(recipe_name__in=saved_recipes_titles)

# Add Saved Recipes for janet_doe
for recipe in saved_recipes:
    SavedRecipe.objects.create(user=janet_doe, recipe=recipe, is_recommendation=True)

print(f"{janet_doe.username} saved the following recipes:")
for recipe in saved_recipes:
    print(recipe.recipe_name)