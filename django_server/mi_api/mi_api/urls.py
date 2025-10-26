# mi_api/urls.py
from django.contrib import admin
from django.urls import path, include # Asegúrate de que 'include' esté importado

urlpatterns = [
    path('admin/', admin.site.urls),
    
    # AÑADE ESTA LÍNEA:
    # Esto le dice a Django que cualquier URL que empiece con 'api/'
    # debe ser manejada por la app 'computadoras'.
    path('api/', include('computadoras.urls')),
]
