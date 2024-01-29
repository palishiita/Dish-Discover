from rest_framework import permissions

class IsModeratorOrIssuer(permissions.BasePermission):
    def has_permission(self, request, view):
        if request.user.is_authenticated:
            if view.action in ['issue', 'issueOnRecipe'] or request.user.has_mod_rights:
                return True
        return False

from rest_framework import permissions

