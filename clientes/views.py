from django.shortcuts import render
from django.core import serializers
from django.http import JsonResponse
from .models import Clientes 
# Create your views here.

def view2(request, codigocli):    
    qs = Clientes.objects.filter(codigo=codigocli)
    qs_json = serializers.serialize('json', qs)

    for cliente in qs:
        json_response = {
            'id':cliente.pk, 
            'codigo':cliente.codigo,
            'nombreCliente':cliente.nombreCliente,
            'apellidosCliente':cliente.apellidosCliente,
            'porcentaje':cliente.porcentaje,
            'saldoMonedero':cliente.saldoMonedero,
            'estatus':cliente.estatus,
            }
    return JsonResponse(json_response)