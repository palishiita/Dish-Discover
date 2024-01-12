from django.contrib import admin
from DishDiscoverDjango.models import TagCategory, Tag, User, PreferredTag, Comment, SavedRecipe, LikedRecipe, Ingredient, ReportTicket, Recipe, RecipeTag, RecipeIngredient
admin.site.register(TagCategory)
admin.site.register(Tag)
admin.site.register(User)
admin.site.register(PreferredTag)
admin.site.register(Comment)
admin.site.register(SavedRecipe)
admin.site.register(LikedRecipe)
admin.site.register(Ingredient)
admin.site.register(ReportTicket)
admin.site.register(Recipe)
admin.site.register(RecipeTag)
admin.site.register(RecipeIngredient)

# Register your models here.
