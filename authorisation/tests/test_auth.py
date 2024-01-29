from rest_framework.authtoken.models import Token
from rest_framework.test import APIClient
from authorisation.tests.test_data import valid_login_data, create_users
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
  
    response_data = json.loads(response.content)
    assert 'token' in response_data
    
@pytest.mark.django_db
def test_login():
    client = APIClient()

    # Create a user for testing
    user = User.objects.create_user(username='testuser', password='testpassword')

    # Prepare data for a valid login
    login_data = {'username': 'testuser', 'password': 'testpassword'}

    url = '/api/auth/login' # Replace 'login' with the actual name or path of your login view
    response = client.post(url, data=login_data)
    # Check if the login was successful (status code 200)
    assert response.status_code == 200, response.json()

    # Check if the response contains the token
    response_data = json.loads(response.content)
    assert 'token' in response_data

    # Optionally, you can decode the token to inspect its content
    token = response_data['token']
    # Add more assertions based on your token structure if needed

    # # For example, you can use the token for authenticated requests
    # client.credentials(HTTP_AUTHORIZATION=f'Token {token}')
    # authenticated_response = client.get('/api/some-authenticated-endpoint/')
    # assert authenticated_response.status_code == 200, authenticated_response.json()