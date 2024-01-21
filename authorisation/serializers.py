from rest_framework import serializers
from DishDiscoverDjango.models import DishDiscoverUser
from rest_framework.decorators import api_view



class RegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    password2 = serializers.CharField(write_only=True)

    class Meta:
        model = DishDiscoverUser
        fields = ['username', 'password', 'password2', 'email', 'first_name', 'last_name']


    def create(self, validated_data):
        user = DishDiscoverUser(
            email=self.validated_data['email'],
            username=self.validated_data['username'],
            has_mod_rights=False,
            is_premium=False,
        )
        password = self.validated_data['password']
        password2= self.validated_data['password2']
        
        if password != password2:
            raise serializers.ValidationError({'password': 'Password must match!'})
        user.set_password(password)
        user.save()
        return user
    
