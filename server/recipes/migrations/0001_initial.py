# Generated by Django 5.0 on 2024-01-28 16:38

import django.contrib.auth.models
import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
    ]

    operations = [
        migrations.CreateModel(
            name='DishDiscoverUser',
            fields=[
                ('user_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL)),
                ('has_mod_rights', models.BooleanField()),
                ('picture', models.BinaryField(blank=True, null=True)),
                ('description', models.CharField(blank=True, max_length=150, null=True)),
                ('is_premium', models.BooleanField()),
                ('unban_date', models.DateField(blank=True, null=True)),
            ],
            options={
                'verbose_name': 'user',
                'verbose_name_plural': 'users',
                'abstract': False,
            },
            bases=('auth.user',),
            managers=[
                ('objects', django.contrib.auth.models.UserManager()),
            ],
        ),
        migrations.CreateModel(
            name='Ingredient',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('calorie_density', models.FloatField(null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Tag',
            fields=[
                ('name', models.CharField(max_length=50, primary_key=True, serialize=False)),
                ('is_predefined', models.BooleanField()),
            ],
        ),
        migrations.CreateModel(
            name='TagCategory',
            fields=[
                ('category_name', models.CharField(max_length=50, primary_key=True, serialize=False)),
            ],
        ),
        migrations.CreateModel(
            name='Recipe',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('recipe_name', models.CharField(max_length=50)),
                ('content', models.CharField(max_length=10000)),
                ('picture', models.TextField(blank=True, null=True)),
                ('description', models.CharField(max_length=150)),
                ('is_boosted', models.BooleanField()),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.dishdiscoveruser')),
            ],
        ),
        migrations.CreateModel(
            name='LikedRecipe',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_recommendation', models.BooleanField()),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.dishdiscoveruser')),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.recipe')),
            ],
            options={
                'unique_together': {('user', 'recipe')},
            },
        ),
        migrations.AddField(
            model_name='dishdiscoveruser',
            name='liked_recipes',
            field=models.ManyToManyField(related_name='users_liked_recipes', through='recipes.LikedRecipe', to='recipes.recipe'),
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.CharField(max_length=1000)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.dishdiscoveruser')),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.recipe')),
            ],
        ),
        migrations.CreateModel(
            name='RecipeIngredient',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('amount', models.FloatField()),
                ('unit', models.CharField(max_length=10)),
                ('ingredient', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.ingredient')),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.recipe')),
            ],
            options={
                'unique_together': {('recipe', 'ingredient')},
            },
        ),
        migrations.AddField(
            model_name='recipe',
            name='ingredients',
            field=models.ManyToManyField(through='recipes.RecipeIngredient', to='recipes.ingredient'),
        ),
        migrations.CreateModel(
            name='ReportTicket',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('reason', models.CharField(max_length=150)),
                ('comment', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='recipes.comment')),
                ('issuer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='issuer', to='recipes.dishdiscoveruser')),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.recipe')),
                ('violator', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='violator', to='recipes.dishdiscoveruser')),
            ],
        ),
        migrations.CreateModel(
            name='SavedRecipe',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_recommendation', models.BooleanField()),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.recipe')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.dishdiscoveruser')),
            ],
            options={
                'unique_together': {('user', 'recipe')},
            },
        ),
        migrations.AddField(
            model_name='dishdiscoveruser',
            name='saved_recipes',
            field=models.ManyToManyField(related_name='users_saved_recipes', through='recipes.SavedRecipe', to='recipes.recipe'),
        ),
        migrations.CreateModel(
            name='RecipeTag',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('weight', models.FloatField()),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.recipe')),
                ('tag', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.tag')),
            ],
            options={
                'unique_together': {('recipe', 'tag')},
            },
        ),
        migrations.AddField(
            model_name='recipe',
            name='tags',
            field=models.ManyToManyField(through='recipes.RecipeTag', to='recipes.tag'),
        ),
        migrations.CreateModel(
            name='PreferredTag',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('weight', models.FloatField()),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.dishdiscoveruser')),
                ('tag', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.tag')),
            ],
            options={
                'unique_together': {('user', 'tag')},
            },
        ),
        migrations.AddField(
            model_name='ingredient',
            name='tag',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.tag'),
        ),
        migrations.AddField(
            model_name='dishdiscoveruser',
            name='preferred_tags',
            field=models.ManyToManyField(related_name='users_preferred_tags', through='recipes.PreferredTag', to='recipes.tag'),
        ),
        migrations.AddField(
            model_name='tag',
            name='tag_category',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recipes.tagcategory'),
        ),
    ]