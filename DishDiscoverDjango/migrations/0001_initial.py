# Generated by Django 5.0 on 2024-01-12 21:06

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Recipe',
            fields=[
                ('recipe_id', models.IntegerField(primary_key=True, serialize=False)),
                ('recipe_name', models.CharField(max_length=50)),
                ('content', models.CharField(max_length=10000)),
                ('picture', models.BinaryField(blank=True, null=True)),
                ('description', models.CharField(max_length=150)),
                ('is_boosted', models.BooleanField()),
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
            name='User',
            fields=[
                ('user_id', models.IntegerField(primary_key=True, serialize=False)),
                ('username', models.CharField(max_length=50)),
                ('has_mod_rights', models.BooleanField()),
                ('email', models.EmailField(max_length=254)),
                ('password', models.CharField(max_length=50)),
                ('picture', models.BinaryField(blank=True, null=True)),
                ('description', models.CharField(blank=True, max_length=150, null=True)),
                ('is_premium', models.BooleanField()),
                ('unban_date', models.DateField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('comment_id', models.IntegerField(primary_key=True, serialize=False)),
                ('content', models.CharField(max_length=1000)),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.recipe')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.user')),
            ],
        ),
        migrations.CreateModel(
            name='Ingredient',
            fields=[
                ('ingredient_id', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=50)),
                ('calorie_density', models.FloatField()),
                ('tag', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.tag')),
            ],
        ),
        migrations.AddField(
            model_name='tag',
            name='tag_category',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.tagcategory'),
        ),
        migrations.CreateModel(
            name='ReportTicket',
            fields=[
                ('report_id', models.IntegerField(primary_key=True, serialize=False)),
                ('reason', models.CharField(max_length=150)),
                ('comment', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.comment')),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.recipe')),
                ('issuer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='issuer', to='DishDiscoverDjango.user')),
                ('violator', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='violator', to='DishDiscoverDjango.user')),
            ],
        ),
        migrations.AddField(
            model_name='recipe',
            name='author',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.user'),
        ),
        migrations.CreateModel(
            name='RecipeIngredient',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('amount', models.FloatField()),
                ('unit', models.CharField(max_length=10)),
                ('ingredient', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.ingredient')),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.recipe')),
            ],
            options={
                'unique_together': {('recipe', 'ingredient')},
            },
        ),
        migrations.CreateModel(
            name='RecipeTag',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('weight', models.FloatField()),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.recipe')),
                ('tag', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.tag')),
            ],
            options={
                'unique_together': {('recipe', 'tag')},
            },
        ),
        migrations.CreateModel(
            name='SavedRecipe',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_recommendation', models.BooleanField()),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.recipe')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.user')),
            ],
            options={
                'unique_together': {('user', 'recipe')},
            },
        ),
        migrations.CreateModel(
            name='PreferredTag',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('weight', models.FloatField()),
                ('tag', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.tag')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.user')),
            ],
            options={
                'unique_together': {('user', 'tag')},
            },
        ),
        migrations.CreateModel(
            name='LikedRecipe',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_recommendation', models.BooleanField()),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.recipe')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DishDiscoverDjango.user')),
            ],
            options={
                'unique_together': {('user', 'recipe')},
            },
        ),
    ]
