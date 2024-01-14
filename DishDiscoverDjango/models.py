from django.db import models
from django.contrib.auth.models import User

# Tag Category Model
class TagCategory(models.Model):
    category_name = models.CharField(max_length=50, primary_key=True)

# Tag Model
class Tag(models.Model):
    name = models.CharField(max_length=50, primary_key=True)
    tag_category = models.ForeignKey(TagCategory, on_delete=models.CASCADE)
    is_predefined = models.BooleanField()

# User Model
class DishDiscoverUser(User):
    user_id = models.IntegerField(primary_key=True)
    has_mod_rights = models.BooleanField()
    picture = models.BinaryField(null=True, blank=True)
    description = models.CharField(max_length=150, null=True, blank=True)
    is_premium = models.BooleanField()
    unban_date = models.DateField(null=True, blank=True)
    preferred_tags = models.ManyToManyField(Tag, through='PreferredTag')


# Preferred Tags Model
class PreferredTag(models.Model):
    user = models.ForeignKey(DishDiscoverUser, on_delete=models.CASCADE)
    tag = models.ForeignKey(Tag, on_delete=models.CASCADE)
    weight = models.FloatField()
    class Meta:
        unique_together = ('user', 'tag')

# Comment Model
class Comment(models.Model):
    comment_id = models.IntegerField(primary_key=True)
    user = models.ForeignKey(DishDiscoverUser, on_delete=models.CASCADE)
    recipe = models.ForeignKey('Recipe', on_delete=models.CASCADE)
    content = models.CharField(max_length=1000)

# Saved Recipes Model
class SavedRecipe(models.Model):
    user = models.ForeignKey(DishDiscoverUser, on_delete=models.CASCADE)
    recipe = models.ForeignKey('Recipe', on_delete=models.CASCADE)
    is_recommendation = models.BooleanField()
    class Meta:
        unique_together = ('user', 'recipe')

# Liked Recipes Model
class LikedRecipe(models.Model):
    user = models.ForeignKey(DishDiscoverUser, on_delete=models.CASCADE)
    recipe = models.ForeignKey('Recipe', on_delete=models.CASCADE)
    is_recommendation = models.BooleanField()
    class Meta:
        unique_together = ('user', 'recipe')

# Ingredient Model
class Ingredient(models.Model):
    ingredient_id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=50)
    calorie_density = models.FloatField()
    tag = models.ForeignKey(Tag, on_delete=models.CASCADE)
    
# Report Tickets Model
class ReportTicket(models.Model):
    report_id = models.IntegerField(primary_key=True)
    recipe = models.ForeignKey('Recipe', on_delete=models.CASCADE)
    violator = models.ForeignKey(DishDiscoverUser, related_name='violator', on_delete=models.CASCADE)
    issuer = models.ForeignKey(DishDiscoverUser, related_name='issuer', on_delete=models.CASCADE)
    comment = models.ForeignKey(Comment, on_delete=models.CASCADE, null=True, blank=True)
    reason = models.CharField(max_length=150)
    
# Recipe Model
class Recipe(models.Model):
    recipe_id = models.IntegerField(primary_key=True)
    author = models.ForeignKey(DishDiscoverUser, on_delete=models.CASCADE)
    recipe_name = models.CharField(max_length=50)
    content = models.CharField(max_length=10000)
    picture = models.BinaryField(null=True, blank=True)
    description = models.CharField(max_length=150)
    is_boosted = models.BooleanField()
    ingredients = models.ManyToManyField(Ingredient, through='RecipeIngredient')
    tags = models.ManyToManyField(Tag, through='RecipeTag')

# Recipe Tags Model
class RecipeTag(models.Model):
    recipe = models.ForeignKey(Recipe, on_delete=models.CASCADE)
    tag = models.ForeignKey(Tag, on_delete=models.CASCADE)
    weight = models.FloatField()
    class Meta:
        unique_together = ('recipe', 'tag')

# Recipe Ingredients Model
class RecipeIngredient(models.Model):
    recipe = models.ForeignKey(Recipe, on_delete=models.CASCADE)
    ingredient = models.ForeignKey(Ingredient, on_delete=models.CASCADE)
    amount = models.FloatField()
    unit = models.CharField(max_length=10)
    class Meta:
        unique_together = ('recipe', 'ingredient')
