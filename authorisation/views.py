from django.http import JsonResponse
from .models import *
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import *

from .serializers import RegistrationSerializer


def registration_view(request):

    if request.method == 'POST':
        serializer = RegistrationSerializer(data=request.data)
        data = {}
        if serializer.is_valid():
            user = serializer.create()
            data['response'] = 'successfully registered a new user'
            data['email'] = user.emal
            data['username'] = user.username
        else: 
            data: serializer.errors
        return Response(data)