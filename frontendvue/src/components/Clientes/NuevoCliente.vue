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
                    @keypress="restrigirChars($event)"
                    @paste.prevent
                    :state="codiState(form.codigo)"
                    aria-describedby="input-live-help validar-codigo"
                    placeholder="Código de barras">
                </b-form-input>
                <b-form-invalid-feedback id="validar-codigo">
                  Debe ingresar los 10 digítos numericos de la tarjeta
                </b-form-invalid-feedback>
              </b-form-group>
            </b-col>
            <b-col>
              <b-form-group label="Nombre">
                <b-form-input
                    type="text"
                    v-model="form.nombreCliente"
                    :state="nombreState(form.nombreCliente)"
                    aria-describedby="input-live-help validar-nombre"
                    placeholder="Nombre">
                </b-form-input>
                <b-form-invalid-feedback id="validar-nombre">
                  Debe ingresar el nombre completo
                </b-form-invalid-feedback>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col>       
              <b-form-group label="Apellidos">
                <b-form-input
                    type="text"
                    v-model="form.apellidosCliente"
                    :state="apeState(form.apellidosCliente)"
                    aria-describedby="input-live-help validar-apellidos"
                    placeholder="Apellidos">
                </b-form-input>
                <b-form-invalid-feedback id="validar-apellidos">
                  Debe ingresar apellido(s) completo(s)
                </b-form-invalid-feedback>
              </b-form-group>
            </b-col>
            <b-col>
              <b-form-group label="Teléfono">
                <b-form-input
                    type="text"
                    v-model="form.telefono"
                    @keypress="restrigirChars($event)"
                    @paste.prevent
                    :state="telState(form.telefono)"
                    aria-describedby="input-live-help validar-telefono"
                    placeholder="Teléfono">
                </b-form-input>
                <b-form-invalid-feedback id="validar-telefono">
                  Debe ingresar 10 digítos numericos
                </b-form-invalid-feedback>
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
        nombreCliente: '',
        apellidosCliente: '',
        codigo: '',
        telefono: ''
      }        
    }
  },
  props: ['configToken'],
  methods: {
    verModalNewCli(){
    this.$refs['my-modal'].show()
    },
    restrigirChars(event){
      if (event.charCode === 0 || /\d/.test(String.fromCharCode(event.charCode))) {
        return true
      } else {
          event.preventDefault();
      }
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
    nombreState(nombre){
      if (nombre == '' || nombre.length == 0){
        return null
      }else{
        return nombre.length > 2 ? true : false
      }      
    },
    apeState(apellido){
     if (apellido == '' || apellido.length == 0){
        return null
      }else{
        return apellido.length > 4 ? true : false
      }
    },
    telState(telefono){
      if (telefono == '' || telefono.length == 0){
        return null
      }else{
        return Math.floor(telefono).toString().length == 10 ? true : false
      }
    },
    newCliente(){
      if(this.codiState(this.form.codigo) && this.nombreState(this.form.nombreCliente) && this.apeState(this.form.apellidosCliente) && this.telState(this.form.telefono)){

        const path = `${process.env.BASE_URI}api/clientes/`
      
        axios.post(path, this.form, this.configToken).then((response) => {
          this.form.nombreCliente = ''
          this.form.apellidosCliente = ''
          this.form.codigo = ''
          this.form.telefono = ''
          this.$refs['my-modal'].hide()
          this.$emit('actualizarLIstCliente')
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
  },
  created() {
  }
}
</script>