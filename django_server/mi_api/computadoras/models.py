# computadoras/models.py
from django.db import models

class Computadora(models.Model):
    # ... (tus campos: tipo, marca, cpu, etc.) ...
    tipo = models.CharField(max_length=50)
    marca = models.CharField(max_length=50)
    cpu = models.CharField(max_length=50)
    ram = models.CharField(max_length=20)
    hdd_ssd = models.CharField(max_length=20)
    fecha_creacion = models.DateTimeField(auto_now_add=True)

    # --- AÑADE ESTO ---
    class Meta:
        db_table = 'computadoras'  # Le dice a Django que use esta tabla
    # ------------------

    def __str__(self):
        return f"{self.marca} - {self.tipo} ({self.cpu})"