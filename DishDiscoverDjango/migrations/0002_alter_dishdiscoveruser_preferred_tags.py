# Generated by Django 5.0 on 2024-01-20 21:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('DishDiscoverDjango', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='dishdiscoveruser',
            name='preferred_tags',
            field=models.ManyToManyField(related_name='users_preferred_tags', through='DishDiscoverDjango.PreferredTag', to='DishDiscoverDjango.tag'),
        ),
    ]