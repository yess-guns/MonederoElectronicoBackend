<template>
  <b-container>
    <b-row class="my-3">
      <b-col>
        <h1>Nuevo Pago</h1>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-form-group label="Importe Total">
          <b-form-input
              type="text"
              v-model="pago.importeTotal"
              placeholder="Ingrese el importe total">
          </b-form-input>
        </b-form-group>
      </b-col>
      <b-col>
        <b-form-group label="Escanea el código de la tarjeta">
          <b-form-input
              type="text"
              v-model="codigo"
              @keyup.enter="buscarCliente()"
              :disabled="inputCodigo"
              placeholder="Código de la tarjeta">
          </b-form-input>
        </b-form-group>
      </b-col>
    </b-row>
    <template v-if="dataCliente.length != 0">    
      <b-row>
        <b-col cols="12">
          <h4>Nombre del Cliente:</h4> {{`${dataCliente.nombreCliente} ${dataCliente.apellidosCliente}`}}
        </b-col>
        <b-col cols="12">
          <h4>Saldo:</h4> $ {{pago.saldoClienteAnterior.toFixed(2)}}
        </b-col>
        <b-col cols="12">
          <h4>Porcentaje de descuento:</h4> {{pago.porcentajePago}}%
        </b-col>
        <b-col cols="12">
          <h4>Total a crédito:</h4> $ {{ ((pago.importeTotal * pago.porcentajePago) / 100).toFixed(2) }}
        </b-col>
      </b-row>
      <b-row>
        <b-col md="4">
          <h4>Importe efectivo</h4>
          <b-form-group>
            <b-form-input
                type="text"
                v-model="pago.importeEfectivoTarjeta"
                placeholder="Ingrese el importe en efectivo">
            </b-form-input>
          </b-form-group>
        </b-col>
      </b-row>
      <b-row>
        <b-col md="4">
          <h4>Cantidad en Monedero Electrónico</h4>
          <b-form-group>
            <b-form-input
                type="text"
                v-model="pago.importeMonedeto"
                placeholder="Ingrese la cantidad que desee usar">
            </b-form-input>
          </b-form-group>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <b-button variant="danger"> Cancelar </b-button> <b-button @click="pagar()" variant="primary"> Pagar </b-button>
        </b-col>
      </b-row>
    </template>
  </b-container>
</template>

<script>
import axios from 'axios';
import swal from 'sweetalert'; 

export default {
  data () {
    return {
      dataCliente: [],
      inputCodigo: false,
      pago: {
        folio:'FLA-210720',
        importeTotal:'300',
        porcentajePago:0,
        saldoClienteAnterior:'',
        SaldoClienteFinal:'',
        importeEfectivoTarjeta:0,
        importeMonedeto:0,
        cliente:''
      }
    }
  },
  methods: {
    buscarCliente(){
      let codigo = this.codigo
      const path = `http://127.0.0.1:8000/cliente/codigo/${codigo}/`
      axios.get(path).then((response) => {
        this.dataCliente = response.data
        this.pago.porcentajePago = this.dataCliente.porcentaje
        this.pago.saldoClienteAnterior = this.dataCliente.saldoMonedero
        this.pago.SaldoClienteFinal = this.dataCliente.saldoMonedero
        this.inputCodigo = true
        console.log(response.data)
      })
    },
    pagar(){
      this.pago.cliente = this.dataCliente.id
      this.pago.SaldoClienteFinal = ((this.pago.importeTotal * this.pago.porcentajePago) / 100).toFixed(2)
      console.log(this.pago)

      const path = 'http://127.0.0.1:8000/api/pago-descuento/'
      
      axios.post(path, this.pago).then((response) => {
        swal({
          title: "Guardado exitosamente",
          text: "   ",
          icon: "success",
          timer: 2000,
          button: false,
        });
      })
      .catch((error) => {console.log(error)})
      
    }
  }
}
</script>
    