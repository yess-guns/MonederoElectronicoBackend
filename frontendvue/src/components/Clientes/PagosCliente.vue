<template>
  <b-container>
    <b-row class="my-3">
      <b-col cols="9">
        <h1>Información de Pagos</h1>
      </b-col>
      <b-col cols="3">
        <b-button :to="{ name:'ListCliente' }" variant="primary">Regresar</b-button>
      </b-col>
    </b-row>
    <template v-if="cliente != ''">
      <b-row  class="my-5">
        <b-col cols="4">
          <h4>Nombre del Cliente:</h4> {{`${cliente.nombreCliente} ${cliente.apellidosCliente}`}}
        </b-col>
        <b-col cols="3">
          <h4>Saldo:</h4> $ {{cliente.saldoMonedero.toFixed(2)}}
        </b-col>
        <b-col cols="4"  class="text-center">
          <h4>Porcentaje de descuento:</h4> {{cliente.porcentaje}}%
        </b-col>
      </b-row>
      <template v-if="pagos.length != 0">
        <b-row>
          <b-table striped hover :items="pagos" :fields="filas">
            <template v-slot:cell(porcentajePago)="row">
              {{ row.value }} %
            </template>
            <template v-slot:cell(importeTotal)="row">
              $ {{ row.value.toFixed(2) }}
            </template>
            <template v-slot:cell(saldoClienteAnterior)="row">
              $ {{ row.value.toFixed(2) }}
            </template>
            <template v-slot:cell(SaldoClienteFinal)="row">
              $ {{ row.value.toFixed(2) }}
            </template>
            <template v-slot:cell(importeEfectivoTarjeta)="row">
              $ {{ row.value.toFixed(2) }}
            </template>
            <template v-slot:cell(importeMonedeto)="row">
              $ {{ row.value.toFixed(2) }}
            </template>
          </b-table>
        </b-row>
      </template>
      <template v-else>
        <b-row>
          <b-col cols="4">
            <h4>No hay pagos</h4>
          </b-col>
        </b-row>
      </template>
    </template>
  </b-container>
</template>

<script>
import axios from 'axios';

export default {
  data () {
    return {
      cliente: '',
      pagos: [],
      filas: [
        { key: 'folio', label: 'Folio', sortable: true, sortDirection: 'desc' },
        { key: 'fecha', label: 'Fecha de pago' },
        { key: 'importeTotal', label: 'Importe Total', sortable: false, class: 'text-right' },
        { key: 'porcentajePago', label: '% descuento ', sortable: false, class: 'text-right' },
        { key: 'saldoClienteAnterior', label: 'Saldo Cliente Anterior', sortable: false, class: 'text-right' },
        { key: 'SaldoClienteFinal', label: 'Saldo Cliente Final', sortable: false, class: 'text-right' },
        { key: 'importeEfectivoTarjeta', label: 'Importe Efectivo / Tarjeta', sortable: false, class: 'text-right' },
        { key: 'importeMonedeto', label: 'Importe Monedero', sortable: false, class: 'text-right' }
      ]
    }
  },
  methods: {
    
  },
  created() {
    const path = `http://127.0.0.1:8000/cliente/pagos/${this.$route.params.clienteId}/`
    axios.get(path).then((response) => {
      console.log(response.data)
      this.cliente = response.data.cliente[0]
      this.pagos = response.data.pagos
      
    })
  }
}
</script>
    