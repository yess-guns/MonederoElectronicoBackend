<template>
  <b-container>
    <b-row>
      <b-col>
        <b-button variant="primary" @click="verModalNewCli">
            Nuevo Cliente <b-icon icon="plus-circle"></b-icon>
        </b-button>
      </b-col>
    </b-row>
    <b-modal ref="my-modal" hide-footer title="Nuevo Cliente">
      <div class="d-block">
        <form ref="form">
          <b-row>
            <b-col>
              <b-form-group label="Código de barras">
                <b-form-input
                    type="text"
                    v-model="form.codigo"
                    placeholder="Código de barras">
                </b-form-input>
              </b-form-group>
            </b-col>
            <b-col>
              <b-form-group label="Nombre">
                <b-form-input
                    type="text"
                    v-model="form.nombreCliente"
                    placeholder="Nombre">
                </b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col>       
              <b-form-group label="Apellidos">
                <b-form-input
                    type="text"
                    v-model="form.apellidosCliente"
                    placeholder="Apellidos"
                    >
                </b-form-input>
              </b-form-group>
            </b-col>
            <b-col>
              <b-form-group label="Teléfono">
                <b-form-input
                    type="text"
                    v-model="form.telefono"
                    placeholder="Teléfono">
                </b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-button @click="newCliente" variant="primary">Guardar</b-button>
        </form>
      </div>
    </b-modal>  
  </b-container>
  
      

</template>

<script>
import axios from 'axios';
import swal from 'sweetalert'; 

export default {
  data () {
    return {
        form: {
          nombreCliente: 'Juan',
          apellidosCliente: 'Morales',
          codigo: '321654684',
          telefono: '15616556'
        }        
    }
  },
  methods: {
    verModalNewCli(){
    this.$refs['my-modal'].show()
    },
    newCliente(){
      const path = 'http://127.0.0.1:8000/api/clientes/'
      axios.post(path, this.form).then((response) => {
        this.form.nombreCliente = response.data.nombreCliente
        this.form.apellidosCliente = response.data.apellidosCliente
        this.form.codigo = response.data.codigo
        this.form.telefono = response.data.telefono
        swal("Guardado exitosamente", "", "success")
      })
      .catch((error) => {console.log(error)})
      
    }
  },
  created() {
  }
}
</script>