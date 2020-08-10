<template>
  <div class="container h-100">
		<div class="d-flex justify-content-center h-100">
			<div class="user_card">
				<div class="d-flex justify-content-center">
					<div class="brand_logo_container">
						<img src="@/img/logo.png" class="brand_logo" alt="Logo">
					</div>
				</div>
				<div class="d-flex justify-content-center form_container">
					<form>
						<div class="input-group mb-3">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-user"></i></span>
							</div>
							<input type="text" name="" class="form-control input_user" v-model="data.username"
              placeholder="Ingrese su nombre de usuario">
						</div><br>
						<div class="input-group mb-2">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
							<input type="password" name="" class="form-control input_pass"
              v-model="data.password"
              placeholder="Ingrese su contraseña">
						</div><br><br>
						<div class="d-flex justify-content-center mt-3 login_container">
				 	  <button type="button" @click="login()" name="button" class="btn login_btn">Ingresar</button>
				   </div>
					</form>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import axios from 'axios';
import swal from 'sweetalert'; 
import { mapState, mapMutations } from 'vuex';

export default {
  name: 'Login',
  data () {
    return {
      data:  {
        username: "",
        password: ""
      }
    }
  },
  methods: {
    ...mapMutations(['validarSesion']),
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
        let modulo = user.is_staff ? 'reporte-pagos' : 'nuevo-pago'
        setTimeout(function(){ esto.$router.push(modulo) }, 2000);
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
  computed: {
    ...mapState(['userData']),
  },  
  created(){
    this.validarSesion()
    if(JSON.stringify(this.userData) == '{}'){
      //no esta logueado
    }else{
       if(this.userData.tipo){//Es admin
        this.$router.push('reporte-pagos')
      }else{//es cajero
        this.$router.push('nuevo-pago')
      }
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
	body,
		html {
			margin: 0;
			padding: 0;
			height: 100%;
			background: #fff !important;
		}
		.user_card {
			height: 400px;
			width: 350px;
			margin-top: auto;
			margin-bottom: auto;
			background: #f39c12;
			position: relative;
			display: flex;
			justify-content: center;
			flex-direction: column;
			padding: 10px;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-webkit-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-moz-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			border-radius: 5px;

		}
		.brand_logo_container {
			position: absolute;
			height: 170px;
			width: 170px;
			top: -75px;
			border-radius: 50%;
			background: #fff;
			padding: 10px;
			text-align: center;
		}
		.brand_logo {
			height: 150px;
			width: 150px;
			border-radius: 50%;
			border: 2px solid white;
		}
		.form_container {
			margin-top: 100px;
		}
		.login_btn {
			width: 100%;
			background: #c0392b !important;
			color: white !important;
		}
		.login_btn:focus {
			box-shadow: none !important;
			outline: 0px !important;
		}
		.login_container {
			padding: 0 2rem;
		}
		.input-group-text {
			background: #c0392b !important;
			color: white !important;
			border: 0 !important;
			border-radius: 0.25rem 0 0 0.25rem !important;
		}
		.input_user,
		.input_pass:focus {
			box-shadow: none !important;
			outline: 0px !important;
		}
		.custom-checkbox .custom-control-input:checked~.custom-control-label::before {
			background-color: #c0392b !important;
		}
    .container{
      margin-top: 100px;
    }
</style>
