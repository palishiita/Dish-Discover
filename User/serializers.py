from rest_framework import serializers
from recipes.models import *
from rest_framework.decorators import api_view

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = DishDiscoverUser
        fields = '__all__'
