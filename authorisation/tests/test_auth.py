from rest_framework.authtoken.models import Token
from rest_framework.test import APIClient
from authorisation.tests.test_data import valid_login_data
from recipes.models import *
import json
import pytest 


@pytest.mark.django_db
def test_registration():
    client = APIClient()

    # Prepare data for a valid registration
    valid_data = valid_login_data()[0]

    url = '/api/auth/register'
    response = client.post(url, valid_data)


    assert response.status_code == 200, response.json()
    assert DishDiscoverUser.objects.filter(email="test@example.com").count() == 1
  