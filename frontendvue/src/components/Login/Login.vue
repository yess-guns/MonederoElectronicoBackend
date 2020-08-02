<template>
  <b-container>
    <b-row class="justify-content-md-center mt-5">
      <b-col cols="5" class="text-center"><h1>Login</h1></b-col>
    </b-row>
    <b-row class="justify-content-md-center mt-5">
      <b-col cols="5">
        <b-form-group label="Usuario">
          <b-form-input
              type="text"
              v-model="data.username"
              placeholder="Ingrese su nombre de usuario">
          </b-form-input>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row class="justify-content-md-center mt-5">
      <b-col cols="5">
        <b-form-group label="Contraseña">
          <b-form-input
              type="password"
              v-model="data.password"
              placeholder="Ingrese su contraseña">
          </b-form-input>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row class="justify-content-md-center mt-5">
      <b-col cols="5" class="text-center">
        <b-button @click="login()" variant="primary">Ingresar</b-button>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import axios from 'axios';
import swal from 'sweetalert'; 

export default {
  name: 'Login',
  data () {
    return {
      data:  {
        username: "Papacito",
        password: "123123"
      }
    }
  },
  methods: {
    async login(){
      const path = `${process.env.BASE_URI}accounts/auntentificar/`
      let datos = new FormData();
      datos.append('user', this.data.username);
      datos.append('pass', this.data.password);
      let res = await axios.post(path, datos);
      console.log(res.data)
      if (res.data.response == 'OK'){
        let user = res.data.dataUser[0]
        const path2 = `${process.env.BASE_URI}api_generar_token/`
        axios.post(path2, this.data).then((response) => {//obtener token
          console.log(response.data)          
          let usuario = {
            'nombre': `${user.first_name} ${user.last_name}`,
            'tipo': user.is_staff,
            'token': response.data.token,
            'logged': true
          }
          localStorage.setItem("Usuario", JSON.stringify(usuario));
        })
        .catch((error) => {console.log(error)})
        swal({
          title: "Sesión iniciada",
          text: "   ",
          icon: "success",
          timer: 2000,
          button: false,
        });
        let esto = this
        setTimeout(function(){ esto.$router.push('nuevo-pago') }, 2000);
      }else if(res.data.response == 'err'){
        swal({
          title: "Usuario o contraseña incorrectos",
          text: "   ",
          icon: "error",
          timer: 2000,
          button: false,
        });
      }  
    }
  },
  created(){
    let dataUser = JSON.parse(localStorage.getItem("Usuario"))
    if(dataUser != null){
      if(dataUser.logged){//esta logueado
        this.$router.push('nuevo-pago')
      }
    }else{
      //no esta logueado
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
