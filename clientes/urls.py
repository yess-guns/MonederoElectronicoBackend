from django.urls import path
from rest_framework import routers

from .viewsets import ClientesViewSet, PagoDescuentoViewSet

from clientes import views as clientes

route = routers.SimpleRouter()
route.register('clientes',ClientesViewSet)
route.register('pago-descuento',PagoDescuentoViewSet)

urlpatterns = route.urls

prueba_patterns = ([
    path('codigo/<codigocli>/',clientes.getCliente),
    path('pagos/<int:idCliente>/',clientes.getPagosCliente),
],"clientes")
