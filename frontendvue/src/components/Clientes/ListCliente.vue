<template>
  <b-container>
    <b-row>
      <b-col>
        <h1>Clientes</h1>
        <NuevoCliente @actualizarLIstCliente="getClientes"/>
      </b-col>
    </b-row>
    <b-row>
      <b-table striped hover :items="clientes" :fields="filas">
        <template v-slot:cell(porcentaje)="row">
          {{ row.value }} %
        </template>
        <template v-slot:cell(saldoMonedero)="row">
          $ {{ row.value.toFixed(2) }}
        </template>
        <template v-slot:cell(estatus)="row">
          <b-button :variant="row.value == 1 ? 'success' : 'danger'" size="sm">{{ row.value == 1 ? 'Activo' : 'Inactivo' }} </b-button>
          
        </template>
        <template v-slot:cell(Acciones)="data">
          <b-button @click="modalVer(data.index)" variant="info"><b-icon-person-circle></b-icon-person-circle> Ver</b-button>          
          <b-button @click="modalEdit(data.index)" variant="warning"><b-icon-pencil-square></b-icon-pencil-square> Editar</b-button>
          <b-button :to="{ name:'PagosCliente', params: {clienteId: data.item.id} }" variant="secondary"><b-icon-receipt></b-icon-receipt> Pagos</b-button>          
          
        </template>
      </b-table>
      <EditCliente ref="editCliente" @actualizarLIstCliente="getClientes"/>
      <VerCliente ref="verInfoCliente"/>
    </b-row>    
  </b-container>  

</template>

<script>
import NuevoCliente from '@/components/Clientes/NuevoCliente'
import EditCliente from '@/components/Clientes/EditCliente'
import VerCliente from '@/components/Clientes/VerCliente'
import axios from 'axios';
import swal from 'sweetalert'; 

export default {
  components: {
    NuevoCliente,
    EditCliente,
    VerCliente
  },
  data () {
    return {
      clientes: [],
      filas: [
          { key: 'nombreCliente', label: 'Nombre', sortable: true, sortDirection: 'desc' },
          { key: 'apellidosCliente', label: 'Apellidos' },
          { key: 'codigo', label: 'Código de barras', sortable: false, sortDirection: 'desc' },
          { key: 'porcentaje', label: '% descuento ', sortable: false, class: 'text-center' },
          { key: 'saldoMonedero', label: 'Saldo en monedero', sortable: false, class: 'text-center' },
          { key: 'estatus', label: 'Estatus', sortable: false, class: 'text-center' },
          'Acciones',
        ]
    }
  },
  methods: {
    getClientes(){
      const path = `${process.env.BASE_URI}api/clientes/`
      axios.get(path).then((response) => {
        this.clientes = response.data
        console.log(response.data)
      })
    },
    modalEdit(index){
      this.$refs.editCliente.verModalEditCli(this.clientes[index])
    },
    modalVer(index){
      this.$refs.verInfoCliente.verModalCliente(this.clientes[index])
    }
  },
  created() {
    this.getClientes()
  }
}
</script>