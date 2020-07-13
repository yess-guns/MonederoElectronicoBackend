<template>
  <b-container>
    <b-row>
      <b-col>
        <h1>Clientes</h1>
        <b-button variant="primary">Nuevo</b-button>
      </b-col>
    </b-row>
    <b-row>
      <b-table striped hover :items="clientes" :fields="filas"></b-table>
    </b-row>
  </b-container>

  
  

</template>

<script>
import axios from 'axios';

export default {
  data () {
    return {
      clientes: [],
      filas: [
          { key: 'nombreCliente', label: 'Nombre', sortable: true, sortDirection: 'desc' },
          { key: 'apellidosCliente', label: 'Apellidos' },
          { key: 'codigo', label: 'Código de barras', sortable: false, sortDirection: 'desc' },
          { key: 'porcentaje', label: 'Porcentaje descuento ', sortable: false, class: 'text-center' },
          { key: 'saldoMonedero', label: 'Saldo en monedero', sortable: false, class: 'text-center' },
          { key: 'estatus', label: 'Estatus', sortable: false, class: 'text-center' }
        ]
    }
  },
  methods: {
    getClientes(){
      const path = 'http://127.0.0.1:8000/api/clientes/'
      axios.get(path).then((response) => {
        this.clientes = response.data
      })
    }
  },
  created() {
    this.getClientes()
  }
}
</script>