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
              v-model="importeT"
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
              placeholder="Código de la tarjeta">
          </b-form-input>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row>
      {{dataCliente}}
    </b-row>
  </b-container>
</template>

<script>
import axios from 'axios';

export default {
  data () {
    return {
      importeT: '',
      codigo: '',
      dataCliente: []
    }
  },
  methods: {
    buscarCliente(){
      let codigo = this.codigo
      const path = `http://127.0.0.1:8000/cliente/codigo/${codigo}/`
      axios.get(path).then((response) => {
        this.dataCliente = response.data
        console.log(response.data)
      })
    },
  }
}
</script>
    