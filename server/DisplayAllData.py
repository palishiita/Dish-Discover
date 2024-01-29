from recipes.models import TagCategory, Tag, User, PreferredTags, Comment, SavedRecipes, LikedRecipes, Ingredient, ReportTickets, Recipe, RecipeTags, RecipeIngredients


# tagCategories = [
#     TagCategory(category_name='Cousine').save(),
#     TagCategory(category_name='Difficulty').save(),
#     TagCategory(category_name='Ingredient').save(),
#     TagCategory(category_name='Other').save()
# ]

# tags = [
#     Tag(name='Polish',tag_category=tagCategories[0],is_predefined = True).save(),
#     Tag(name='Indian',tag_category=tagCategories[0],is_predefined = True).save(),
#     Tag(name='Silesian',tag_category=tagCategories[0],is_predefined = True).save(),
#     Tag(name='Easy',tag_category=tagCategories[1],is_predefined = True).save(),
#     Tag(name='Hard',tag_category=tagCategories[1],is_predefined = True).save(),
#     Tag(name='Tomato',tag_category=tagCategories[2],is_predefined = True).save(),
#     Tag(name='Avocado',tag_category=tagCategories[2],is_predefined = True).save()
# ]

# # Create Users
# users = [
#     User(username='john_doe', has_mod_rights=True, email='john@example.com', password='password123', is_premium=False).save(),
#     User(username='jane_doe', has_mod_rights=False, email='jane@example.com', password='password456', is_premium=True).save()
# ]
# # Create Preferred Tags
# prefferedTags = [
#     PreferredTags(user=users[0], tag=tags[1], weight=0.8).save(),
#     PreferredTags(user=users[1], tag=tags[0], weight=0.6).save(),
#     PreferredTags(user=users[0], tag=tags[2], weight=0.8).save(),
#     PreferredTags(user=users[1], tag=tags[3], weight=0.6).save()
# ]

# # Create Ingredients
# ingredients = [
#     Ingredient(name='Tomato', calorie_density=20.0, tag=tags[5]).save(),
#     Ingredient(name='Avocado', calorie_density=50.0, tag=tags[6]).save()
# ]
# # Create Recipes
# recipes = [
#     Recipe(author=users[0], recipe_name='Spaghetti Bolognese', content='Delicious spaghetti recipe...',
#                                 description='Classic Italian dish', is_boosted=True).save(),
#     Recipe(author=users[1], recipe_name='Chocolate Cake', content='Decadent chocolate cake recipe...',
#                                 description='Perfect dessert for any occasion', is_boosted=False).save()
# ]


# # Add Recipe Tags
# recipeTags = [
#     RecipeTags(recipe=recipes[0], tag=tags[0], weight=0.8).save(),
#     RecipeTags(recipe=recipes[1], tag=tags[0], weight=0.5).save(),
#     RecipeTags(recipe=recipes[1], tag=tags[1], weight=0.9).save()
# ]
# # Add Recipe Ingredients
# recipeIngredients = [
#     RecipeIngredients(recipe=recipes[0], ingredient=ingredients[0], amount=200.0, unit='g').save(),
#     RecipeIngredients(recipe=recipes[1], ingredient=ingredients[1], amount=250.0, unit='g').save()
# ]
# # Create Comments
# comments = [
#     Comment(user=users[0], recipe=recipes[0], content='This chocolate cake is amazing!').save(),
#     Comment(user=users[1], recipe=recipes[1], content='I love spaghetti bolognese!').save()
# ]
# # Create Saved Recipes and Liked Recipes
# savedRecipes = [
#     SavedRecipes(user=users[0], recipe=recipes[1], is_recommendation=True).save(),
#     SavedRecipes(user=users[1], recipe=recipes[0], is_recommendation=False).save()
# ]
# likedRecipes = [
#     LikedRecipes(user=users[0], recipe=recipes[1], is_recommendation=True).save(),
#     LikedRecipes(user=users[1], recipe=recipes[0], is_recommendation=False).save()
# ]
# # Create Report Tickets
# reportTickets = [
#     ReportTickets(recipe=recipes[0], violator=users[0], issuer=users[1],
#                              comment=None, reason='Inappropriate content in the recipe description').save(),

#     ReportTickets(recipe=recipes[1], violator=users[1], issuer=users[0],
#                              comment=None, reason='Spammy comment').save()
# ]
# print("Example data added successfully.")
tagCat = TagCategory(category_name='Cousine2')
tagCat.save()
tag = Tag(name='Polish2',tag_category=tagCat,is_predefined = True)
tag.save()
user = User(username='john_doe2', has_mod_rights=True, email='john@example.com2', password='password123', is_premium=False)
user.save()
PreferredTags(user=user, tag=tag, weight=0.8).save(),