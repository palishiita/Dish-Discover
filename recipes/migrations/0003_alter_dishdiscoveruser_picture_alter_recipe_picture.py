# Generated by Django 5.0 on 2024-01-29 02:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('recipes', '0002_reportticket_responder'),
    ]

    operations = [
        migrations.AlterField(
            model_name='dishdiscoveruser',
            name='picture',
            field=models.ImageField(blank=True, null=True, upload_to='profile_pictures'),
        ),
        migrations.AlterField(
            model_name='recipe',
            name='picture',
            field=models.ImageField(blank=True, null=True, upload_to='recipe_pictures'),
        ),
    ]
