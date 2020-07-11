from django.contrib import admin
from .models import Clientes, PagoDescuento

# Register your models here.

class ClientesAdmin(admin.ModelAdmin):
  list_display = ('id','codigo','telefono','nombreCliente','creacion','modificacion')

class PagoDescuentoAdmin(admin.ModelAdmin):
  list_display = ('id','folio','fecha','importeTotal','porcentajePago','saldoClienteAnterior','SaldoClienteFinal','importeEfectivoTarjeta','importeMonedeto','cliente_id')

admin.site.register(Clientes, ClientesAdmin)
admin.site.register(PagoDescuento, PagoDescuentoAdmin)