from django.urls import path
from .views import *
from rest_framework.routers import SimpleRouter

router=SimpleRouter()

router.register(r'users', UserViewSet, basename='users')

urlpatterns = router.urls

urlpatterns += [
    path('users/username/<str:username>/', UserViewSet.as_view({'get':'retrieve'}), name = 'get_user_by_username'),    
]

# urlpatterns = [
#     path('users/', UserViewSet.as_view({'get':'list'}), name = 'get_all_users'),
#     path('users/id/<int:pk>/', UserViewSet.as_view({'get':'retrieve'}), name = 'get_user_by_id'),
#     path('users/username/<str:username>/', UserViewSet.as_view({'get':'retrieve'}), name = 'get_user_by_username'),
# ]
