# computadoras/views.py
from rest_framework import viewsets
from .models import Computadora
from .serializers import ComputadoraSerializer

class ComputadoraViewSet(viewsets.ModelViewSet):
    """
    API endpoint que permite ver y editar computadoras.
    Automáticamente provee las acciones .list(), .retrieve(),
    .create(), .update() y .destroy().
    """
    queryset = Computadora.objects.all().order_by('-fecha_creacion')
    serializer_class = ComputadoraSerializer
