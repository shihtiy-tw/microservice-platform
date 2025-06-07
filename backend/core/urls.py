"""
URL Configuration for core project.
"""
from django.conf import settings
from django.contrib import admin
from django.http import JsonResponse
from django.urls import include, path


def health_check(request):
    """Health check endpoint for Kubernetes probes."""
    return JsonResponse({"status": "ok"})


urlpatterns = [
    path("admin/", admin.site.urls),
    path("health/", health_check, name="health_check"),
    path("api-auth/", include("rest_framework.urls")),
    # Add your API URLs here
    # path('api/', include('apps.api.urls')),
]

if settings.DEBUG:
    import debug_toolbar

    urlpatterns.append(path("__debug__/", include(debug_toolbar.urls)))
