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
              @keypress="restrigirChars($event)"
              @paste.prevent
              :state="importeState(pago.importeTotal)"
              aria-describedby="input-live-help validar-importe"
              placeholder="Ingrese el importe total">
          </b-form-input>
          <b-form-invalid-feedback id="validar-importe">
            Debe ingresar el importe total
          </b-form-invalid-feedback>
        </b-form-group>
      </b-col>
      <b-col>
        <b-form-group label="Escanea el código de la tarjeta">
          <b-form-input
              type="text"
              v-model="codigo"
              @keypress="restrigirChars($event)"
              @paste.prevent
              @keyup.enter="buscarCliente()"
              :disabled="inputCodigo"
              :state="codiState(codigo)"
              aria-describedby="input-live-help validar-codigo"
              placeholder="Código de la tarjeta">
          </b-form-input>
          <b-form-invalid-feedback id="validar-codigo">
            Debe escanear ingresar los 10 digítos numericos de la tarjeta
          </b-form-invalid-feedback>
        </b-form-group>
      </b-col>
    </b-row>
    <template v-if="dataCliente.length != 0">{{importeEfecT}}
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
          <h4>Importe en efectivo/tarjeta</h4>
          <b-form-group>
            <b-form-input
                type="text"
                disabled
                v-model="pago.importeEfectivoTarjeta"
                @keypress="restrigirChars($event)"
                @paste.prevent
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
                @keypress="restrigirChars($event)"
                @paste.prevent
                placeholder="Ingrese la cantidad que desee usar">
            </b-form-input>
          </b-form-group>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <b-button @click="resetForm()" variant="danger"> Cancelar </b-button> <b-button @click="validar()" variant="primary"> Pagar </b-button>
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
      codigo: '',
      inputCodigo: false,
      pago: {
        folio:'FLA-210720',
        importeTotal:'300',
        porcentajePago:0,
        saldoClienteAnterior:0,
        SaldoClienteFinal:0,
        importeEfectivoTarjeta:0,
        importeMonedeto:0,
        cliente:''
      },
      cliente: {
        saldoMonedero: 0
      }
    }
  },
  methods: {
    buscarCliente(){
      let codigo = this.codigo
      const path = `${process.env.BASE_URI}cliente/codigo/${codigo}/`
      axios.get(path).then((response) => {
        this.dataCliente = response.data
        this.pago.porcentajePago = this.dataCliente.porcentaje
        this.pago.saldoClienteAnterior = this.dataCliente.saldoMonedero
        this.pago.SaldoClienteFinal = this.dataCliente.saldoMonedero
        this.inputCodigo = true
        console.log(response.data)
      })
    },
    codiState(codigo){
      if (codigo == '' || codigo.length == 0){
        return null
      }else if (Math.floor(codigo).toString().length == 10){
        return true
      }else{
        return false
      }
    },
    importeState(importe){
      if (importe == '' || importe.length == 0){
        return null
      }else if (Math.floor(importe).toString().length > 0 && importe > 0){
        return true
      }else{
        return false
      }
    },
    restrigirChars(event){
      if (event.charCode === 0 || /\d/.test(String.fromCharCode(event.charCode))) {
        return true
      } else {
          event.preventDefault();
      }
    },
    validar(){
      if(this.importeState(this.pago.importeTotal)){
        if(this.pago.importeMonedeto <= this.dataCliente.saldoMonedero){
          if((parseInt(this.pago.importeEfectivoTarjeta) + parseInt(this.pago.importeMonedeto)) == this.pago.importeTotal){

            this.pago.cliente = this.dataCliente.id
            let saldoRestante = (this.dataCliente.saldoMonedero - this.pago.importeMonedeto)
            let saldoGenerado = ((this.pago.importeTotal * this.pago.porcentajePago) / 100).toFixed(2)
            this.pago.SaldoClienteFinal = (parseInt(saldoRestante) + parseInt(saldoGenerado))
            this.cliente.saldoMonedero = this.pago.SaldoClienteFinal
            this.pago.folio = this.getFolio()
            //Llamar función pagar()
            this.pagar()
          }else{
            swal({
              title: "Cantidades erroneas",
              text: "   ",
              icon: "error",
              timer: 2000,
              button: false,
            });
          }
        }else{
           swal({
            title: "No cuenta con saldo suficiente para usar",
            text: "   ",
            icon: "error",
            timer: 2000,
            button: false,
          });
        }
      }
      else{
        swal({
         title: "Ingrese el importe Total",
          text: "   ",
          icon: "error",
          timer: 2000,
          button: false,
        });
      }
    },
    pagar(){
      const path = `${process.env.BASE_URI}api/pago-descuento/`
      axios.post(path, this.pago).then((response) => {
        swal({
          title: "Guardado exitosamente",
          text: "   ",
          icon: "success",
          timer: 2000,
          button: false,
        });
        const path = `${process.env.BASE_URI}api/clientes/${this.dataCliente.id}/`
        axios.patch(path, this.cliente).then((res) => { //editar saldo de cliente
          console.log(this.cliente)
          this.resetForm()
        })
        .catch((error) => {console.log(error)})
        
      })
      .catch((error) => {console.log(error)})
      
    },
    resetForm(){
      this.dataCliente = []
      this.codigo = ''
      this.inputCodigo = false
      this.pago.folio = '',
      this.pago.importeTotal = 0,
      this.pago.porcentajePago = 0,
      this.pago.saldoClienteAnterior = 0,
      this.pago.SaldoClienteFinal = 0,
      this.pago.importeEfectivoTarjeta = 0,
      this.pago.importeMonedeto = 0,
      this.pago.cliente = 0
      this.cliente.saldoMonedero = 0
    },
    getFolio(){
      const dateTime = Date.now();
      const timestamp = Math.floor(dateTime / 1000).toString();
      var valor = timestamp.split('');

      var date = new Date();
      var year = date.getFullYear();
      var month = date.getMonth()+1;
      var dt = date.getDate();

      if (dt < 10) {
        dt = '0' + dt;
      }
      if (month < 10) {
        month = '0' + month;
      }
      var arrayYear = year.toString().split('')
      
      var newYear = arrayYear[2]+arrayYear[3]
      var nfecha = newYear + month + dt
      var folio = nfecha+valor[5]+valor[6]+valor[7]+valor[8]+valor[9]
      return folio
    }
  },
  computed: {
    importeEfecT(){
      this.pago.importeEfectivoTarjeta = this.pago.importeTotal - this.pago.importeMonedeto
    }
  }
}
</script>
    