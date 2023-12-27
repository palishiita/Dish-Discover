from django.db import models

# Create your models here.

class Recipe(models.Model):
    #make authorId FK

    recipeId = models.AutoField(primary_key=True)
    authorId = models.IntField() #FK
    recipeName = models.CharField(max_length=50)
    content = models.TextField(max_length=10000)
    picture = models.BinaryField()(max_length=150)
    is_boosted = models.BooleanField()

 

class Ingredient(models.Model):
    #tag_name FK

    ingredientId = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    calorie_density = models.FloatField()
    tag_name = models.CharField(max_length = 50) #FK

class Tag(models.Model):
    #add tag_category

    name = models.AutoField(primary_key=True)
    #tag_category tag_category
    is_predefined = models.BoolField()

class User(models.Model):
    useriD = models.AutoField(primary_key=True)
    username = models.CharField(max_length=50)
    has_mod_rights = models.BoolField()
    email = models.CharField(max_length=True)
    password = models.CharField(max_length=50)
    picture = models.BinaryField()
    description = models.CharField(max_length=150)
    is_premium = models.Boolfield()
    unban_date = models.DateField()

class Comment(models.Model):
    #userId, recipeId FKs

    commentId = models.AutoField(primary_key=True)
    userId = models.IntField() #FK 
    recipeId = models.IntField()#FK
    content = models.CharField(max_length=10000)

