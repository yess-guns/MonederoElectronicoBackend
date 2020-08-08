// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import Vuex from 'vuex'

import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.config.productionTip = false
Vue.use(BootstrapVue)
Vue.use(IconsPlugin)
Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    userData: {},
    configToken: {}
  },
  mutations: {
    validarSesion(state) {
      let dataUser = JSON.parse(localStorage.getItem("Usuario"))
      if(dataUser != null){
        if(dataUser.logged){//esta logueado
          state.userData = dataUser
          state.configToken = {
            headers: {
              'Authorization': `Token ${dataUser.token}`
            }
          }
          //this.$router.push('nuevo-pago')
        }
      }else{
        //no esta logueado
      }
    },
    logOutVuex(state) {
      localStorage.removeItem('Usuario');
      router.go('login')
    }
  },
  actions: {},
  getters: {},
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>',
  store,
})
