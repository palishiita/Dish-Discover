# DishDiscoverDjango/models.py
from django.db import models

class TagCategory(models.Model):
    category_name = models.CharField(max_length=50, primary_key=True)

class User(models.Model):
    user_id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=50, unique=True)
    has_mod_rights = models.BooleanField(default=False)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=50)
    picture = models.BinaryField(null=True, blank=True)
    description = models.CharField(max_length=150, null=True, blank=True)
    is_premium = models.BooleanField(default=False)
    unban_date = models.DateField(null=True, blank=True)

class PreferredTags(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    tag = models.ForeignKey(TagCategory, on_delete=models.CASCADE)
    weight = models.FloatField()

    class Meta:
        unique_together = ('user', 'tag')

class Comments(models.Model):
    comment_id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    recipe_id = models.ForeignKey('Recipes', on_delete=models.CASCADE)
    content = models.CharField(max_length=1000)

class SavedRecipes(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    recipe_id = models.ForeignKey('Recipes', on_delete=models.CASCADE)
    is_recommendation = models.BooleanField()

class LikedRecipes(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    recipe_id = models.ForeignKey('Recipes', on_delete=models.CASCADE)
    is_recommendation = models.BooleanField()

class Tags(models.Model):
    name = models.CharField(max_length=50, primary_key=True)
    tag_category = models.ForeignKey(TagCategory, on_delete=models.CASCADE)
    is_predefined = models.BooleanField()

class Ingredients(models.Model):
    ingredient_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    calorie_density = models.FloatField()
    tag_name = models.ForeignKey(Tags, on_delete=models.CASCADE)

class ReportTickets(models.Model):
    report_id = models.AutoField(primary_key=True)
    recipe_id = models.ForeignKey('Recipes', on_delete=models.CASCADE)
    violator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_tickets')
    issuer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='issued_tickets')
    comment_id = models.ForeignKey(Comments, on_delete=models.CASCADE, null=True, blank=True)
    reason = models.CharField(max_length=150)

class Recipes(models.Model):
    recipe_id = models.AutoField(primary_key=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    recipe_name = models.CharField(max_length=50)
    content = models.CharField(max_length=10000)
    picture = models.BinaryField(null=True, blank=True)
    description = models.CharField(max_length=150)
    is_boosted = models.BooleanField()

class RecipeTags(models.Model):
    recipe_id = models.ForeignKey(Recipes, on_delete=models.CASCADE)
    tag = models.ForeignKey(Tags, on_delete=models.CASCADE)
    weight = models.FloatField()

class RecipeIngredients(models.Model):
    recipe_id = models.ForeignKey(Recipes, on_delete=models.CASCADE)
    ingredient = models.ForeignKey(Ingredients, on_delete=models.CASCADE)
    amount = models.FloatField()
    unit = models.CharField(max_length=10)
