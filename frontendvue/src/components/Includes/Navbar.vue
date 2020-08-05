<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="info">
      <b-navbar-brand>
        <b-button size="sm" variant="white" v-b-toggle.v-b-toggle.sidebar-border>
          <b-icon-justify font-scale="2.5" variant="white"></b-icon-justify>
        </b-button>NavBar
      </b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
    </b-navbar>
    <template>
      <div> 
        <b-sidebar id="sidebar-border" sidebar-class="border-right border-danger">
        <template v-slot:footer="{ hide }">
          <div class="d-flex bg-info text-light align-items-center px-3 py-2">
            <p class="mr-auto"></p>
            <b-button size="sm" @click="logOut()">Cerrar sesión</b-button>
          </div>
        </template>
          <div class="px-3 py-2">
            <p>
              Usser: {{userData.nombre}}
            </p>
            <nav class="mb-3">
              <b-nav vertical>
                <b-nav-item active>Nuevo pago</b-nav-item>
                <b-nav-item href="#link-1">Clientes</b-nav-item>
                <b-nav-item href="#link-2">Pagos</b-nav-item>
              </b-nav>
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
  };
</script>