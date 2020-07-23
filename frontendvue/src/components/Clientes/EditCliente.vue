<template>
  <b-container>    
    <b-modal ref="my-modal-edit" hide-footer title="Editar Cliente">
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
          <b-row>
            <b-col>
              <b-form-group label="% descuento">
                <b-form-input
                    type="text"
                    v-model="form.porcentaje"
                    @keypress="restrigirChars($event)"
                    @paste.prevent
                    :state="porcenState(form.porcentaje)"
                    aria-describedby="input-live-help validar-porcentaje"
                    placeholder="Porcentaje de descuento">
                </b-form-input>
                <b-form-invalid-feedback id="validar-porcentaje">
                  Debe ingresar una cantidad mayor a 0 pero menor a 100
                </b-form-invalid-feedback>
              </b-form-group>
            </b-col>
            <b-col>
              <b-form-group label="Estatus">
                <b-form-radio v-model="form.estatus" name="some-radios" value="1">Activo</b-form-radio>
                <b-form-radio v-model="form.estatus" name="some-radios" value="0">Inactivo</b-form-radio>
              </b-form-group>
            </b-col>
          </b-row>
          <b-button @click="editCliente" variant="primary">Guardar</b-button>
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
          telefono: '',
          porcentaje: '',
          estatus: ''
        }        
    }
  },
  methods: {
    verModalEditCli(datosCli){
      this.id = datosCli.id
      this.form.nombreCliente = datosCli.nombreCliente
      this.form.apellidosCliente = datosCli.apellidosCliente
      this.form.codigo = datosCli.codigo
      this.form.telefono = datosCli.telefono
      this.form.porcentaje = datosCli.porcentaje
      this.form.estatus = datosCli.estatus
      this.$refs['my-modal-edit'].show()
      //console.log(datosCli)
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
      }else if (Math.floor(codigo).toString().length == 10 && codigo.length < 11){
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
        return (Math.floor(telefono).toString().length == 10 && telefono.length < 11) ? true : false
      }
    },
    porcenState(porcentaje){
      if (porcentaje == '' || porcentaje.length == 0){
        return null
      }else{
        let porcen = Math.floor(porcentaje).toString()
        return (porcen > 0 && porcen < 100 && porcentaje.toString().length < 3) ? true : false
      }
    },
    editCliente(){
      if(this.codiState(this.form.codigo) && this.nombreState(this.form.nombreCliente) && this.apeState(this.form.apellidosCliente) && this.telState(this.form.telefono) && this.porcenState(this.form.porcentaje)){

        const path = `${process.env.BASE_URI}api/clientes/${this.id}/`      
        axios.put(path, this.form).then((response) => {
          this.$refs['my-modal-edit'].hide()
          swal("Guardado exitosamente", "", "success")
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