from django.shortcuts import render
from django.core import serializers
from django.http import JsonResponse
from .models import Clientes, PagoDescuento
# Create your views here.

def getCliente(request, codigocli):    
    dataCliente = Clientes.objects.filter(codigo=codigocli)
    json_response = {'cliente': list(dataCliente.values('id','codigo','nombreCliente','apellidosCliente','porcentaje','saldoMonedero','estatus'))}
    return JsonResponse(json_response)

def getPagosCliente(request, idCliente):    
    dataCliente = Clientes.objects.filter(id=idCliente)
    dataPagos = PagoDescuento.objects.filter(cliente=idCliente)

    json_response = {'cliente': list(dataCliente.values('id','codigo','nombreCliente','apellidosCliente','porcentaje','saldoMonedero','estatus')), 'pagos': list(dataPagos.values('folio','fecha','importeTotal','porcentajePago','saldoClienteAnterior','SaldoClienteFinal','importeEfectivoTarjeta','importeMonedeto'))}
    return JsonResponse(json_response)

def getPagosXdia(request, fecha):
    dataPagos = PagoDescuento.objects.filter(fecha=fecha)

    json_response = {'pagos': list(dataPagos.values('folio','fecha','importeTotal','porcentajePago','importeEfectivoTarjeta','importeMonedeto'))}
    return JsonResponse(json_response)