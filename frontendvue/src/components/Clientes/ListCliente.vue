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
          {{ row.value == 1 ? 'Activo' : 'Inactivo' }} 
        </template>
        <template v-slot:cell(Acciones)="data">
          <b-button @click="modalEdit(data.index)" variant="warning">Editar</b-button>
          <b-button @click="deleteCli(clientes[data.index])"variant="danger">Eliminar</b-button>
        </template>
      </b-table>
      <EditCliente ref="editCliente" @actualizarLIstCliente="getClientes"/>
    </b-row>    
  </b-container>  

</template>

<script>
import NuevoCliente from '@/components/Clientes/NuevoCliente'
import EditCliente from '@/components/Clientes/EditCliente'
import axios from 'axios';
import swal from 'sweetalert'; 

export default {
  components: {
    NuevoCliente,
    EditCliente
  },
  data () {
    return {
      clientes: [],
      filas: [
          { key: 'nombreCliente', label: 'Nombre', sortable: true, sortDirection: 'desc' },
          { key: 'apellidosCliente', label: 'Apellidos' },
          { key: 'codigo', label: 'Código de barras', sortable: false, sortDirection: 'desc' },
          { key: 'porcentaje', label: 'Porcentaje descuento ', sortable: false, class: 'text-center' },
          { key: 'saldoMonedero', label: 'Saldo en monedero', sortable: false, class: 'text-center' },
          { key: 'estatus', label: 'Estatus', sortable: false, class: 'text-center' },
          'Acciones',
        ]
    }
  },
  methods: {
    getClientes(){
      const path = 'http://127.0.0.1:8000/api/clientes/'
      axios.get(path).then((response) => {
        this.clientes = response.data
        console.log(response.data)
      })
    },
    modalEdit(index){
      this.$refs.editCliente.verModalEditCli(this.clientes[index])
    },
    deleteCli(data){
      swal({
        title: "¿Estas seguro de eliminar?",
        text: `Cliente: ${data.nombreCliente} ${data.apellidosCliente}`,
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          const path = `http://127.0.0.1:8000/api/clientes/${data.id}/`
          axios.delete(path).then((response) => {
            this.getClientes()
            swal({
              title: "Eliminado exitosamente",
              text: "   ",
              icon: "success",
              timer: 2000,
              button: false,
            });
          })
          .catch((error) => {console.log(error)})
          
        } else {
          
        }
      });
    }
  },
  created() {
    this.getClientes()
  }
}
</script>