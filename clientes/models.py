from django.db import models

# Create your models here.

class Clientes(models.Model):
    codigo = models.CharField(max_length=255,verbose_name="Código de barras")
    nombreCliente = models.CharField(max_length=255,verbose_name="Nombre") 
    apellidosCliente = models.CharField(max_length=255,verbose_name="Apellidos")
    telefono = models.CharField(max_length=255,verbose_name="Teléfono")
    porcentaje = models.PositiveIntegerField(default=5,verbose_name="Porcentaje descuento")
    saldoMonedero = models.FloatField(default=0.00,verbose_name="Saldo en monedero")
    creacion = models.DateField(auto_now_add=True, verbose_name="Fecha de creación")
    modificacion = models.DateField(auto_now=True, verbose_name="Fecha de edición")
    estatus = models.PositiveIntegerField(default=1,verbose_name="Estatus")

    def __str__(self):
        return self.nombreCliente

class PagoDescuento(models.Model):    
    folio = models.CharField(max_length=50)
    fecha = models.DateField(auto_now_add=True, verbose_name="Fecha de registro")
    importeTotal = models.FloatField(verbose_name="Importe total de venta")
    porcentajePago = models.PositiveIntegerField(verbose_name="Porcentaje descuento del pago")
    saldoClienteAnterior = models.FloatField(verbose_name="Saldo anterior de Cliente")
    SaldoClienteFinal = models.FloatField(verbose_name="Saldo Final de Cliente")
    importeEfectivoTarjeta = models.FloatField(verbose_name="Importe en efectivo o tarjeta C/D")
    importeMonedeto = models.FloatField(verbose_name="Importe monedero eléctronico")
    cliente = models.ForeignKey(Clientes, on_delete=models.CASCADE)
