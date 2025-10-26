# computadoras/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ComputadoraViewSet

# Crea un router y registra nuestro viewset con él.
router = DefaultRouter()
router.register(r'computadoras', ComputadoraViewSet, basename='computadora')

# Las URLs de la API son determinadas automáticamente por el router.
urlpatterns = [
    path('', include(router.urls)),
]