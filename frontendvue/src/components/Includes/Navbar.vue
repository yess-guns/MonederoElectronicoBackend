<template>
  <div>
    <b-navbar toggleable="lg" type="dark" class="navbarBG">
      <b-navbar-brand>
        <b-button size="sm" variant="white" v-b-toggle.v-b-toggle.sidebar-border>
          <b-icon-justify font-scale="2.5" variant="white"></b-icon-justify>
        </b-button>La Casota
      </b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
    </b-navbar>
    <template>
      <div> 
        <b-sidebar id="sidebar-border" sidebar-class="border-right border-danger">
        <template v-slot:footer="{ hide }">
          <div class="d-flex navbarBG text-light align-items-center px-3 py-2">
            <p class="mr-auto"></p>
            <b-button size="sm" @click="logOut()">Cerrar sesión</b-button>
          </div>
        </template>
          <div class="d-flex justify-content-center my-5">
            <div class="brand_logo_container" style="margin-top: 25%;">
              <img src="@/img/logo.png" class="brand_logo" alt="Logo">
            </div>
          </div>
          <div class="px-3 py-5">
            <h5>
              <b-icon-person-circle></b-icon-person-circle> {{userData.nombre}} 
            </h5>
            <p class="text-right">{{ userData.tipo ? 'Admin' : 'Cajero' }}</p>
            <hr>
            <nav class="mb-3">
              <b-list-group>
                <b-list-group-item :to="{ name:'NewPago' }" v-if="!userData.tipo" variant="warning">Nuevo pago</b-list-group-item>

                <b-list-group-item :to="{ name:'ListCliente' }" v-if="!userData.tipo" variant="warning">Clientes</b-list-group-item>

                <b-list-group-item :to="{ name:'ReportePagos' }" v-if="userData.tipo" variant="warning">Reporte Pagos</b-list-group-item>

                <b-list-group-item :to="{ name:'Usuarios' }" v-if="userData.tipo" variant="warning">Usuarios</b-list-group-item>
              </b-list-group>
            </nav>
          </div>
        </b-sidebar>
      </div>
    </template>
  </div>
</template>
<script>
  import { mapState, mapMutations } from 'vuex';
  export default {
    data() {
      return {};
    },
    props: ['userData'],
    methods: {
      ...mapMutations(['logOutVuex']),
      logOut(){
        this.logOutVuex()
        swal({
          title: "Sesión cerrada",
          text: "   ",
          icon: "success",
          timer: 2000,
          button: false,
        });
        //let esto = this
        //setTimeout(function(){ esto.$router.push('login') }, 2000);
        
      }
    },
  };
</script>
<style>
  .navbarBG {
    background: #f39c12 !important;
  }
</style>