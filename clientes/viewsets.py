from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.decorators import action

from django.shortcuts import get_object_or_404

from .models import Clientes, PagoDescuento
from .serializer import ClientesSerializer, PagoDescuentoSerializer



class ClientesViewSet(viewsets.ModelViewSet):
    queryset = Clientes.objects.all()
    serializer_class = ClientesSerializer

class PagoDescuentoViewSet(viewsets.ModelViewSet):
    queryset = PagoDescuento.objects.all()
    serializer_class = PagoDescuentoSerializer

    @action(detail=True, methods=['get'])
    def Clientes(self, request, pk=None):
        queryset = Clientes.objects.filter(PagoDescuento_id=pk)
        serializer = ClientesSerializer(queryset, many=True)
        return Response(serializer.data)
