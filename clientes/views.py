from django.shortcuts import render
from django.core import serializers
from django.http import HttpResponse
from .models import Clientes 
# Create your views here.

def view2(request, codigocli):    
    qs = Clientes.objects.filter(codigo=codigocli)
    qs_json = serializers.serialize('json', qs)

    return HttpResponse(qs_json, content_type='application/json')