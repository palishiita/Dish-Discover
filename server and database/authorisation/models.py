from django.db import models
from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver 
from rest_framework.authtoken.models import Token
from recipes.models import *

# Create your models here.
@receiver(post_save, sender = DishDiscoverUser)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created: 
        Token.objects.create(user=instance)