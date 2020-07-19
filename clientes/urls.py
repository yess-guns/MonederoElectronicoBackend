from django.urls import path
from rest_framework import routers

from .viewsets import ClientesViewSet, PagoDescuentoViewSet

from .views import view2

route = routers.SimpleRouter()
route.register('clientes',ClientesViewSet)
route.register('pago-descuento',PagoDescuentoViewSet)

urlpatterns = route.urls

prueba_patterns = ([
    path('codigo/<codigocli>/',view2,name='codigo'),
],"clientes")
