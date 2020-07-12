from django.urls import path
from rest_framework import routers

from .viewsets import ClientesViewSet, PagoDescuentoViewSet

route = routers.SimpleRouter()
route.register('clientes',ClientesViewSet)
route.register('pago-descuento',PagoDescuentoViewSet)

urlpatterns = route.urls
