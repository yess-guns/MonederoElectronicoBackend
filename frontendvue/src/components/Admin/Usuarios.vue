<template>
  <div>
    <Navbar :userData="userData" />
    <b-container>
        <b-row class="my-3">
        <b-col>
            <h1>Usuarios</h1>
        </b-col>
        </b-row>
        <b-row align-h="end" class="mb-3">
          <b-col class="text-right">
            <b-button variant="primary" @click="verModalNewUser()">Agregar</b-button>
          </b-col>
        </b-row>
        <b-row>
          <b-col>
          <template>
            <div>
              <b-table striped hover :items="users" :fields="filas">
                <template v-slot:cell(is_staff)="row">
                    {{ row.value ? 'Administrador' : 'Cajero' }}
                </template>
                <template v-slot:cell(Acción)="row">
                    <b-button size="sm" @click="row.toggleDetails" class="mr-2" variant="warning"><b-icon-pencil-square></b-icon-pencil-square> Editar
                    </b-button>
                </template>
                <template v-slot:row-details="row">
                  <b-row>
                    <b-col>
                      <b-form-group label="Nombre">
                        <b-form-input
                          type="text"
                          :value="row.item.first_name"
                          :id="'nombre-'+row.index"
                          @change="editar('nombre',row.index)"
                          placeholder="Nombre">
                        </b-form-input>
                      </b-form-group>
                      </b-col>
                      <b-col>       
                      <b-form-group label="Apellidos">
                        <b-form-input
                          type="text"
                          :value="row.item.last_name"
                          :id="'apellidos-'+row.index"
                          @change="editar('apellidos',row.index)"
                          placeholder="Apellidos">
                        </b-form-input>
                      </b-form-group>
                    </b-col>
                    <b-col>
                      <b-form-group label="Usuario">
                        <b-form-input
                            type="text"
                            :value="row.item.username"
                          :id="'usuario-'+row.index"
                          @change="editar('usuario',row.index)"
                            placeholder="usuario">
                        </b-form-input>
                      </b-form-group>
                    </b-col>
                    <b-col>
                      <b-form-group label="Tipo">
                        <b-form-radio :checked="row.item.is_staff?true:false" :id="'Tipo1-'+row.index" :name="'Tipo1-'+row.index" value="true" @change="editar('Tipo1',row.index)">Administrador</b-form-radio>
                        <b-form-radio :checked="row.item.is_staff?true:false" :id="'Tipo2-'+row.index" :name="'Tipo2-'+row.index" value="false" @change="editar('Tipo2',row.index)">Cajero</b-form-radio>
                      </b-form-group>
                    </b-col>
                    <b-col>
                      <b-form-group label="Contraseña">
                        <b-form-input
                            type="password"
                            :id="'pass-'+row.index"
                            @change="editar('pass',row.index)"
                            placeholder="Restablecer contraseña">
                        </b-form-input>
                      </b-form-group>
                    </b-col>
                  </b-row>
                </template>
                </b-table>
            </div>
          </template>
        </b-col>
        </b-row>
        <b-modal ref="my-modal" hide-footer title="Nuevo Usuario">
        <div class="d-block">
          <form ref="form">
            <b-row>
              <b-col>
                <b-form-group label="Nombre">
                    <b-form-input
                        type="text"
                        v-model="nombre"
                        :state="nombreState(nombre)"
                        aria-describedby="input-live-help validar-nombre"
                        placeholder="Nombre">
                    </b-form-input>
                    <b-form-invalid-feedback id="validar-nombre">
                    Debe ingresar el nombre completo
                    </b-form-invalid-feedback>
                </b-form-group>
                </b-col>
                <b-col>       
                <b-form-group label="Apellidos">
                    <b-form-input
                        type="text"
                        v-model="apellidos"
                        :state="apeState(apellidos)"
                        aria-describedby="input-live-help validar-apellidos"
                        placeholder="Apellidos">
                    </b-form-input>
                    <b-form-invalid-feedback id="validar-apellidos">
                    Debe ingresar apellido(s) completo(s)
                    </b-form-invalid-feedback>
                </b-form-group>
              </b-col>
            </b-row>
            <b-row>            
              <b-col>
                <b-form-group label="Usuario">
                    <b-form-input
                        type="text"
                        v-model="username"
                        :state="usernameState(username)"
                        aria-describedby="input-live-help validar-usuario"
                        placeholder="usuario">
                    </b-form-input>
                    <b-form-invalid-feedback id="validar-usuario">
                    Nombre de usuario muy corto
                    </b-form-invalid-feedback>
                </b-form-group>
                </b-col>
                <b-col>
                <b-form-group label="Contraseña">
                    <b-form-input
                        type="password"
                        v-model="password"
                        :state="passwordState(password)"
                        aria-describedby="input-live-help validar-password"
                        placeholder="*******">
                    </b-form-input>
                    <b-form-invalid-feedback id="validar-password">
                    Debe ingresar más de 6 carácteres
                    </b-form-invalid-feedback>
                </b-form-group>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <b-form-group label="Tipo">
                    <b-form-radio v-model="tipo" name="some-radios" value="1">Administrador</b-form-radio>
                    <b-form-radio v-model="tipo" name="some-radios" value="0">Cajero</b-form-radio>
                </b-form-group>
              </b-col>
            </b-row>
            <b-button @click="validar()" variant="primary">Guardar</b-button>
            </form>
        </div>
        </b-modal>
        <b-modal ref="my-modal-edit" hide-footer title="Nuevo Usuario">
        <div class="d-block">
            <form ref="form">
            <b-row>
                <b-col>
                <b-form-group label="Nombre">
                    <b-form-input
                        type="text"
                        v-model="nombre"
                        :state="nombreState(nombre)"
                        aria-describedby="input-live-help validar-nombre"
                        placeholder="Nombre">
                    </b-form-input>
                    <b-form-invalid-feedback id="validar-nombre">
                    Debe ingresar el nombre completo
                    </b-form-invalid-feedback>
                </b-form-group>
                </b-col>
                <b-col>       
                <b-form-group label="Apellidos">
                    <b-form-input
                        type="text"
                        v-model="apellidos"
                        :state="apeState(apellidos)"
                        aria-describedby="input-live-help validar-apellidos"
                        placeholder="Apellidos">
                    </b-form-input>
                    <b-form-invalid-feedback id="validar-apellidos">
                    Debe ingresar apellido(s) completo(s)
                    </b-form-invalid-feedback>
                </b-form-group>
                </b-col>
            </b-row>
            <b-row>            
                <b-col>
                <b-form-group label="Usuario">
                    <b-form-input
                        type="text"
                        v-model="username"
                        :state="usernameState(username)"
                        aria-describedby="input-live-help validar-usuario"
                        placeholder="usuario">
                    </b-form-input>
                    <b-form-invalid-feedback id="validar-usuario">
                    Nombre de usuario muy corto
                    </b-form-invalid-feedback>
                </b-form-group>
                </b-col>
                <b-col>
                <b-form-group label="Contraseña">
                    <b-form-input
                        type="password"
                        v-model="password"
                        :state="passwordState(password)"
                        aria-describedby="input-live-help validar-password"
                        placeholder="*******">
                    </b-form-input>
                    <b-form-invalid-feedback id="validar-password">
                    Debe ingresar más de 6 carácteres
                    </b-form-invalid-feedback>
                </b-form-group>
                </b-col>
            </b-row>
            <b-row>
              <b-col>
                <b-form-group label="Tipo">
                    <b-form-radio v-model="tipo" name="some-radios" value="1">Administrador</b-form-radio>
                    <b-form-radio v-model="tipo" name="some-radios" value="0">Cajero</b-form-radio>
                </b-form-group>
              </b-col>
            </b-row>
            <b-button @click="validar()" variant="primary">Guardar</b-button>
            </form>
        </div>
        </b-modal>
    </b-container>
  </div>
</template>
<script>
  import Navbar from '@/components/Includes/Navbar'
  import axios from 'axios';
  import swal from 'sweetalert';
  import { mapState, mapMutations } from 'vuex';

  export default {
    name: 'Usuarios',
    components: {
      Navbar
    },
    data () {
      return {
        users: [],
         filas: [
          { key: 'first_name', label: 'Nombre', sortable: true, sortDirection: 'desc' },
          { key: 'last_name', label: 'Apellidos' },
          { key: 'username', label: 'Usuario', sortable: false, sortDirection: 'desc' },
          { key: 'is_staff', label: 'Tipo', sortable: false, class: 'text-left' },
          //'Acción',
          'Acción',
        ],
        nombre: '',
        apellidos: '',
        username: '',
        password: '',
        tipo: '',
        options: [
          { text: 'Administrador', value: true },
          { text: 'Cajero', value: 'false' },
        ]
      }
    },
    methods: {
      ...mapMutations(['validarSesion']),
      async getUsers(){
        const path = `${process.env.BASE_URI}accounts/getUsers/`
        let res = await axios.get(path);
        this.users = res.data.dataUsers
        console.log(res.data)
      },
      verModalNewUser(){
        this.$refs['my-modal'].show()
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
      usernameState(username){
        if (username == '' || username.length == 0){
          return null
        }else{
          return username.length > 5 ? true : false
        }
      },
      passwordState(password){
        if (password == '' || password.length == 0){
          return null
        }else{
          return password.length > 5 ? true : false
        }
      },
      validar(){
        if(this.nombreState(this.nombre) && this.apeState(this.apellidos) && this.usernameState(this.username) && this.passwordState(this.password) && this.tipo != ''){
          this.newUser()
        }else{
          swal({
            title: "Verifique la información",
            text: "   ",
            icon: "error",
            timer: 2000,
            button: false,
          });
        }
      },
      async newUser(){
        const path = `${process.env.BASE_URI}accounts/createUser/`
        let datos = new FormData();
        datos.append('nombre', this.nombre);
        datos.append('apellidos', this.apellidos);
        datos.append('username', this.username);
        datos.append('password', this.password);
        datos.append('tipo', this.tipo);
        let res = await axios.post(path, datos);
        if(res.data.response == 'OK'){
          this.getUsers()
          this.$refs['my-modal'].hide()
          swal({
            title: "Guardado exitosamente",
            text: "   ",
            icon: "success",
            timer: 2000,
            button: false,
          });
          this.resetForm()
        }else if(res.data.response == 'Existe'){
          swal({
            title: "Ya existe el nombre de usuario",
            text: "   ",
            icon: "error",
            timer: 2000,
            button: false,
          });
        }          
      },
      resetForm(){
        this.nombre = ''
        this.apellidos = ''
        this.username = ''
        this.password = ''
        this.tipo = ''
      },
      modalEdit(){
        this.$refs['my-modal-edit'].show()
      },
      editar(campo,indice){
        let valor = ''
        switch(campo){
          case 'nombre':
            valor = document.getElementById(campo+'-'+indice).value
            this.editField(campo,indice,valor)
            break;

          case 'apellidos':
            valor = document.getElementById(campo+'-'+indice).value
            this.editField(campo,indice,valor)
            break;

          case 'usuario':
            valor = document.getElementById(campo+'-'+indice).value
            this.editField(campo,indice,valor)
            break;

          case 'pass':
            valor = document.getElementById(campo+'-'+indice).value
            this.editField(campo,indice,valor)
            break;

          case 'Tipo1':
            valor = document.getElementById(campo+'-'+indice).value
            this.editField('Tipo',indice,1)
            this.getUsers()
          break;

          case 'Tipo2':
            valor = document.getElementById(campo+'-'+indice).value
            this.editField('Tipo',indice,0)
            this.getUsers()
          break;
          
          
        }
        
      },
      async editField(campo,indice,valor){
        let idUser = this.users[indice].id
        const path = `${process.env.BASE_URI}accounts/updateUser/`
        let datos = new FormData();
        datos.append('campo', campo);
        datos.append('idUser', idUser);
        datos.append('valor', valor);
        let res = await axios.post(path, datos);
        if(res.data.response == 'OK'){
          swal({
            title: "Éxito",
            text: "   ",
            icon: "success",
            timer: 1000,
            button: false,
          });
          this.getUsers()
        }
      }
    },
    computed:{
      ...mapState(['userData','configToken']),
    },
    created(){
      this.validarSesion()
      if(JSON.stringify(this.userData) == '{}'){//no esta logueado
        this.$router.push('login')
      }else{
        if(this.userData.tipo){//Es admin
          this.getUsers()
        }else{//es cajero
          this.$router.push('nuevo-pago')
        }
      }
    }
  }
</script>