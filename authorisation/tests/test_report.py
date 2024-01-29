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


@pytest.mark.django_db
def test_create_report_ticket_issue_on_comment():
    user = create_users()[0]
    comment = create_comments(user)[0]
    client = APIClient()
    url = reverse('reportticket-issueOnComment')
    data = {'comment_id': comment.id, 'reason': 'Test Reason'}
    client.force_authenticate(user)
    response = client.post(url, data)
    assert response.status_code == 201
    assert ReportTicket.objects.count() == 1

@pytest.mark.django_db
def test_create_report_ticket_issue_on_recipe():
    user = create_users()[0]
    recipe = create_recipes(user)[0]
    client = APIClient()
    url = reverse('reportticket-issueOnRecipe')
    data = {'recipe_id': recipe.id, 'reason': 'Test Reason'}
    client.force_authenticate(user)
    response = client.post(url, data)
    assert response.status_code == 201
    assert ReportTicket.objects.count() == 1

@pytest.mark.django_db
def test_read_report_ticket():
    user = create_users()[0]
    recipe = create_recipes(user)
    client = APIClient()
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reportticket-detail', kwargs={'pk': report_ticket.pk})
    response = client.get(url)
    assert response.status_code == 200
    assert response.data['id'] == report_ticket.id

@pytest.mark.django_db
def test_respond_to_report_ticket():
    user = create_users()[0]
    recipe = create_recipes(user)
    client = APIClient()
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reportticket-respond', kwargs={'pk': report_ticket.pk})
    client.force_authenticate(user)
    response = client.post(url)
    assert response.status_code == 200
    report_ticket.refresh_from_db()
    assert report_ticket.responder == user

@pytest.mark.django_db
def test_ban_violator_from_report_ticket():
    user = create_users()[0]
    recipe = create_recipes(user)
    client = APIClient()
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reportticket-ban', kwargs={'pk': report_ticket.pk})
    ban_date = '2024-02-01'  # Change it to a valid date
    data = {'ban_date': ban_date}
    response = client.post(url, data)
    assert response.status_code == 200
    report_ticket.violator.refresh_from_db()
    assert str(report_ticket.violator.unban_date) == ban_date

@pytest.mark.django_db
def test_cancel_report_ticket():
    user = create_users()[0]
    recipe = create_recipes(user)
    client = APIClient()
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reportticket-cancel', kwargs={'pk': report_ticket.pk})
    response = client.post(url)
    assert response.status_code == 204
    assert ReportTicket.objects.count() == 0