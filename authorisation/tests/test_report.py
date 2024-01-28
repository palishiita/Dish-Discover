from django.test import TestCase
from django.urls import reverse
from rest_framework.test import APIClient
from test_data import *



@pytest.mark.django_db
def test_create_report_ticket():
    user = create_users()[0]
    recipe = create_recipes(user)[0]
    client = APIClient()
    #client.force_authenticate(user)
    url = reverse('reporttickets-list')
    data = {'recipe': recipe.id, 'violator': user.id, 'issuer': user.id, 'reason': 'Test Reason'}
    response = client.post(url, data)
    assert response.status_code == 201
    assert ReportTicket.objects.count() == 1

@pytest.mark.django_db
def test_read_report_ticket():
    user = create_users()[0]
    recipe = create_recipes(user)
    client = APIClient()
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-detail', kwargs={'pk': report_ticket.pk})
    response = client.get(url)
    assert response.status_code == 200
    assert response.data['id'] == report_ticket.id

@pytest.mark.django_db
def test_update_report_ticket():
    user = create_users()[0]
    recipe = create_recipes(user)
    client = APIClient()
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-detail', kwargs={'pk': report_ticket.pk})
    data = { 'recipe': recipe[0].id, 'violator': user.id, 'issuer': user.id,'reason': 'Updated Reason'}
    response = client.put(url, data)
    assert response.status_code == 200
    report_ticket.refresh_from_db()
    assert report_ticket.reason == 'Updated Reason'


@pytest.mark.django_db
def test_delete_report_ticket():
    user = create_users()[0]
    recipe = create_recipes(user)
    client = APIClient()
    report_tickets = create_report_tickets(user, recipe)
    report_ticket = report_tickets[0]
    url = reverse('reporttickets-detail', kwargs={'pk': report_ticket.pk})
    response = client.delete(url)
    assert response.status_code == 204
    assert ReportTicket.objects.count() == len(report_tickets) - 1