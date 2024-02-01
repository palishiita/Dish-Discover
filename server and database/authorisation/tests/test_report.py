from django.test import TestCase
from django.urls import reverse
from rest_framework.test import APIClient
from test_data import *



@pytest.mark.django_db
def test_create_report_ticket():
    user = create_users()[0]
    recipe = create_recipes(user)[0]
    client = APIClient()
    client.force_authenticate(user)
    url = reverse('reporttickets-list')
    data = {'recipe': recipe.id, 'violator': user.id, 'issuer': user.id, 'reason': 'Test Reason'}
    response = client.post(url, data)
    assert response.status_code == 201
    assert ReportTicket.objects.count() == 1

@pytest.mark.django_db
def test_read_report_ticket():
    print("Executing test_read_report_ticket")
    user = create_users()[0]
    recipe = create_recipes(user)
    client = APIClient()
    client.force_authenticate(user)    
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-detail', kwargs={'pk': report_ticket.pk})
    response = client.get(url)
    assert response.status_code == 200, response.json()
    assert response.data['id'] == report_ticket.id

@pytest.mark.django_db
def test_update_report_ticket_authenticated():
    users = create_users()
    user = users[1]
    mod = users[0]
    recipe = create_recipes(user)
    client = APIClient()
    client.force_authenticate(mod)
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-detail', kwargs={'pk': report_ticket.pk})
    data = { 'recipe': recipe[0].id, 'violator': user.id, 'issuer': user.id,'reason': 'Updated Reason'}
    response = client.put(url, data)
    assert response.status_code == 200
    report_ticket.refresh_from_db()
    assert report_ticket.reason == 'Updated Reason'

@pytest.mark.django_db
def test_update_report_ticket_not_authenticated():
    users = create_users()
    user = users[1]
    mod = users[1]
    recipe = create_recipes(user)
    client = APIClient()
    client.force_authenticate(mod)
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-detail', kwargs={'pk': report_ticket.pk})
    data = { 'recipe': recipe[0].id, 'violator': user.id, 'issuer': user.id,'reason': 'Updated Reason'}
    response = client.put(url, data)
    assert response.status_code == 403




@pytest.mark.django_db
def test_delete_report_ticket():
    users = create_users()    
    mod = users[0]
    user = users[1]
    author= users[2]
    recipe = create_recipes(author)
    client = APIClient(mod)
    client.force_authenticate(mod)
    report_tickets = create_report_tickets(user, recipe)
    report_ticket = report_tickets[0]
    url = reverse('reporttickets-detail', kwargs={'pk': report_ticket.pk})
    response = client.delete(url)
    assert response.status_code == 204
    assert ReportTicket.objects.count() == len(report_tickets) - 1


@pytest.mark.django_db
def test_delete_report_ticket_not_authenticated():
    users = create_users()    
    user = users[1]
    author= users[2]
    recipe = create_recipes(author)
    client = APIClient(user)
    client.force_authenticate(user)
    report_tickets = create_report_tickets(user, recipe)
    report_ticket = report_tickets[0]
    url = reverse('reporttickets-detail', kwargs={'pk': report_ticket.pk})
    response = client.delete(url)
    assert response.status_code == 403
    assert ReportTicket.objects.count() == len(report_tickets)


@pytest.mark.django_db
def test_create_report_ticket_issue_on_comment():
    user = create_users()[1]
    recipe = create_recipes(user)[0]
    comment = create_comments(user, recipe)[0]
    client = APIClient()
    url = reverse('reporttickets-issueOnComment')
    data = {'comment_id': comment.id, 'reason': 'Test Reason'}
    client.force_authenticate(user)
    response = client.post(url, data)
    assert response.status_code == 201
    assert ReportTicket.objects.count() == 1

@pytest.mark.django_db
def test_create_report_ticket_issue_on_recipe():
    user = create_users()[1]
    recipe = create_recipes(user)[0]
    client = APIClient()
    url = reverse('reporttickets-issueOnRecipe')
    data = {'recipe_id': recipe.id, 'reason': 'Test Reason'}
    client.force_authenticate(user)
    response = client.post(url, data)
    assert response.status_code == 201
    assert ReportTicket.objects.count() == 1

@pytest.mark.django_db
def test_read_report_ticket():
    users = create_users()    
    mod = users[0]
    user = users[1]
    author= users[2]
    recipe = create_recipes(author)
    client = APIClient(mod)
    client.force_authenticate(mod)
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-detail', kwargs={'pk': report_ticket.pk})
    response = client.get(url)
    assert response.status_code == 200
    assert response.data['id'] == report_ticket.id

@pytest.mark.django_db
def test_read_report_ticket_not_authenticated():
    users = create_users()    
    user = users[1]
    author= users[2]
    recipe = create_recipes(author)
    client = APIClient(user)
    client.force_authenticate(user)
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-detail', kwargs={'pk': report_ticket.pk})
    response = client.get(url)
    assert response.status_code == 403


@pytest.mark.django_db
def test_respond_to_report_ticket():
    user = create_users()[0]
    recipe = create_recipes(user)
    client = APIClient()
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-respond', kwargs={'pk': report_ticket.pk})
    client.force_authenticate(user)
    response = client.post(url)
    assert response.status_code == 200
    report_ticket.refresh_from_db()
    assert report_ticket.responder == user

@pytest.mark.django_db
def test_respond_to_report_ticket_not_authenticated():
    user = create_users()[1]
    recipe = create_recipes(user)
    client = APIClient()
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-respond', kwargs={'pk': report_ticket.pk})
    client.force_authenticate(user)
    response = client.post(url)
    assert response.status_code == 403

@pytest.mark.django_db
def test_ban_violator_from_report_ticket():
    users = create_users()
    user = users[0]
    violator = users[1]
    recipe = create_recipes(user)
    client = APIClient()
    client.force_authenticate(user)
    report_ticket = create_report_tickets2(user, violator, recipe)[0]
    url = reverse('reporttickets-ban', kwargs={'pk': report_ticket.pk})
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
    client.force_authenticate(user)
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-cancel', kwargs={'pk': report_ticket.pk})
    response = client.post(url)
    assert response.status_code == 204
    assert ReportTicket.objects.count() == 0

@pytest.mark.django_db
def test_cancel_report_ticket_not_authenticated():
    user = create_users()[0]
    recipe = create_recipes(user)
    client = APIClient()
    client.force_authenticate(user)
    report_ticket = create_report_tickets(user, recipe)[0]
    url = reverse('reporttickets-cancel', kwargs={'pk': report_ticket.pk})
    response = client.post(url)
    assert response.status_code == 204
    assert ReportTicket.objects.count() == 0


    # @action(detail=False, methods=['GET'], url_name='issueOnUser', url_path='issueOnUser')
    # def issueOnUser(self, request, pk=None):
    #     user = request.user
    #     user_report = ReportTicket.objects.create(
    #             issuer=user, 
    #             violator_id=request.data['violator_id'], 
    #             reason=request.data['reason'], 
    #             violator=User.objects.get(id=request.data['violator_id']),
    #         )
    #     user_report.save()
    #     return Response(status=status.HTTP_201_CREATED)
    
@pytest.mark.django_db
def test_issue_on_user():
    users = create_users()
    user1 = users[0]
    user2 = users[1]
    client = APIClient()
    client.force_authenticate(user1)
    url = reverse('reporttickets-issueOnUser')
    data = {'violator_id': user2.id, 'reason': 'Test Reason'}
    response = client.post(url, data)
    assert response.status_code == 201
    assert ReportTicket.objects.count() == 1