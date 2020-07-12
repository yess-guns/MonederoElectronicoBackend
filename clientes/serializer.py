from rest_framework import serializers

from .models import Clientes, PagoDescuento

class ClientesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Clientes
        fields = '__all__'

class PagoDescuentoSerializer(serializers.ModelSerializer):
    class Meta:
        model = PagoDescuento
        fields = '__all__'

