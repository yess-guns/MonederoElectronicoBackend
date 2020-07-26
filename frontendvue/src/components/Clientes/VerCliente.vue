<template>
  <b-container>    
    <b-modal ref="my-modal-verInfo" size="lg" hide-footer title="Información del Cliente">
      <div class="d-block">
        <form ref="form">
          <b-row>
            <b-col>
              <b-form-group label="Código de barras">
                <b-form-input
                    type="text"
                    v-model="form.codigo"
                    disabled>
                </b-form-input>
              </b-form-group>
            </b-col>
            <b-col>
              <b-form-group label="Nombre Completo">
                <b-form-input
                    type="text"
                    v-model="form.nombreCliente+' '+form.apellidosCliente"
                    disabled>
                </b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col>       
              <b-form-group label="Saldo en monedero">
                <b-form-input
                    type="text"
                    v-model="form.saldoMonedero.toFixed(2)"
                    disabled>
                </b-form-input>
              </b-form-group>
            </b-col>
            <b-col>
              <b-form-group label="Teléfono">
                <b-form-input
                    type="text"
                    v-model="form.telefono"
                    disabled>
                </b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col>
              <b-form-group label="% descuento">
                <b-form-input
                    type="text"
                    v-model="form.porcentaje"
                    disabled>
                </b-form-input>
              </b-form-group>
            </b-col>
            <b-col>
              <b-form-group label="Estatus">
                <b-form-input
                    type="text"
                    v-model="form.estatus==1?'Activo':'Inactivo'"
                    disabled>
                </b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col>
              <b-form-group label="Fecha de registro">
                <b-form-input
                    type="text"
                    v-model="form.creacion"
                    disabled>
                </b-form-input>
              </b-form-group>
            </b-col>
            <b-col>
              <b-form-group label="Última modificación">
                <b-form-input
                    type="text"
                    v-model="form.modificacion"
                    disabled>
                </b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-button @click="$refs['my-modal-verInfo'].hide()" variant="primary">Cerrar</b-button>
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
        id: '',
        form: {          
          nombreCliente: '',
          apellidosCliente: '',
          codigo: '',
          saldoMonedero: 0,
          telefono: '',
          porcentaje: 0,
          estatus: 0,
          creacion: '',
          modificacion: '',
        }        
    }
  },
  methods: {
    verModalCliente(datosCli){
      this.id = datosCli.id
      this.form.nombreCliente = datosCli.nombreCliente
      this.form.apellidosCliente = datosCli.apellidosCliente
      this.form.codigo = datosCli.codigo
      this.form.saldoMonedero = datosCli.saldoMonedero
      this.form.telefono = datosCli.telefono
      this.form.porcentaje = datosCli.porcentaje
      this.form.estatus = datosCli.estatus
      this.form.creacion = datosCli.creacion
      this.form.modificacion = datosCli.modificacion
      this.$refs['my-modal-verInfo'].show()
      //console.log(datosCli)
    }
  },
  created() {
  }
}
</script>