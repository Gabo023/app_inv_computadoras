# computadoras/serializers.py
from rest_framework import serializers
from .models import Computadora

class ComputadoraSerializer(serializers.ModelSerializer):
    class Meta:
        model = Computadora
        # Define los campos que la API mostrará/recibirá
        fields = ['id', 'tipo', 'marca', 'cpu', 'ram', 'hdd_ssd', 'fecha_creacion']