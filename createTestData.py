from recipes.models import TagCategory, Tag, DishDiscoverUser, PreferredTag, Comment, SavedRecipe, LikedRecipe, Ingredient, ReportTicket, Recipe, RecipeTag, RecipeIngredient


tagCategories = [
    TagCategory(category_name='Cousine'),
    TagCategory(category_name='Difficulty'),
    TagCategory(category_name='Ingredient'),
    TagCategory(category_name='Other')
]

for element in tagCategories:
    print(element)
    element.save()

tagCategories=TagCategory.objects.all()

tags = [
    Tag(name='Polish',tag_category=tagCategories[0],is_predefined = True),
    Tag(name='Indian',tag_category=tagCategories[0],is_predefined = True),
    Tag(name='Silesian',tag_category=tagCategories[0],is_predefined = True),
    Tag(name='Easy',tag_category=tagCategories[1],is_predefined = True),
    Tag(name='Hard',tag_category=tagCategories[1],is_predefined = True),
    Tag(name='Tomato',tag_category=tagCategories[2],is_predefined = True),
    Tag(name='Avocado',tag_category=tagCategories[2],is_predefined = True)
]

for element in tags:
    print(element)
    element.save()

tags=Tag.objects.all()

# Create Users
users = [
    DishDiscoverUser(username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False),
    DishDiscoverUser(username='jane_doe', has_mod_rights=False, email='jane@example.com', password='password456', is_premium=True)
]

for element in users:
    print(element)
    element.save()

users = DishDiscoverUser.objects.all()

# Create Preferred Tags
prefferedTags = [
    PreferredTag(user=users[0], tag=tags[1], weight=0.8),
    PreferredTag(user=users[1], tag=tags[0], weight=0.6),
    PreferredTag(user=users[0], tag=tags[2], weight=0.8),
    PreferredTag(user=users[1], tag=tags[3], weight=0.6)
]

for element in prefferedTags:
    element.save()

prefferedTags = PreferredTag.objects.all()

# Create Ingredients
ingredients = [
    Ingredient(name='Tomato', calorie_density=20.0, tag=tags[5]),
    Ingredient(name='Avocado', calorie_density=50.0, tag=tags[6])
]

for element in ingredients:
    element.save()

ingredients = Ingredient.objects.all()
# Create Recipes
recipes = [
    Recipe(author=users[0], recipe_name='Spaghetti Bolognese', content='Delicious spaghetti recipe...',
                                description='Classic Italian dish', is_boosted=True),
    Recipe(author=users[1], recipe_name='Chocolate Cake', content='Decadent chocolate cake recipe...',
                                description='Perfect dessert for any occasion', is_boosted=False)
]

for element in recipes:
    element.save()

recipes = Recipe.objects.all()
# Add Recipe Tags
recipeTags = [
    RecipeTag(recipe=recipes[0], tag=tags[0], weight=0.8),
    RecipeTag(recipe=recipes[1], tag=tags[0], weight=0.5),
    RecipeTag(recipe=recipes[1], tag=tags[1], weight=0.9)
]

for element in recipeTags:
    element.save()

recipeTags = RecipeTag.objects.all()
# Add Recipe Ingredients
recipeIngredients = [
    RecipeIngredient(recipe=recipes[0], ingredient=ingredients[0], amount=200.0, unit='g'),
    RecipeIngredient(recipe=recipes[1], ingredient=ingredients[1], amount=250.0, unit='g')
]

for element in recipeIngredients:
    element.save()

recipeIngredients = RecipeIngredient.objects.all()
# Create Comments
comments = [
    Comment(user=users[0], recipe=recipes[0], content='This chocolate cake is amazing!'),
    Comment(user=users[1], recipe=recipes[1], content='I love spaghetti bolognese!')
]

for element in comments:
    element.save()

comments = Comment.objects.all()
# Create Saved Recipes and Liked Recipes
savedRecipes = [
    SavedRecipe(user=users[0], recipe=recipes[1], is_recommendation=True),
    SavedRecipe(user=users[1], recipe=recipes[0], is_recommendation=False)
]

for element in savedRecipes:
    element.save()

savedRecipes = SavedRecipe.objects.all()

likedRecipes = [
    LikedRecipe(user=users[0], recipe=recipes[1], is_recommendation=True),
    LikedRecipe(user=users[1], recipe=recipes[0], is_recommendation=False)
]

for element in likedRecipes:
    element.save()

likedRecipes = LikedRecipe.objects.all()
# Create Report Tickets
reportTickets = [
    ReportTicket(recipe=recipes[0], violator=users[0], issuer=users[1],
                             comment=None, reason='Inappropriate content in the recipe description'),

    ReportTicket(recipe=recipes[1], violator=users[1], issuer=users[0],
                             comment=None, reason='Spammy comment')
]

for element in reportTickets:
    element.save()


reportTickets = ReportTicket.objects.all()
print("Example data added successfully.")
# TagCategory(category_name='Cousine3').save()
# Tag(name='Polish2',tag_category=TagCategory.get(),is_predefined = True).save()
# User(username='john_doe2', has_mod_rights=True, email='john@example.com2', password='password123', is_premium=False).save()
# PreferredTags(user=user, tag=tag, weight=0.8).save(),