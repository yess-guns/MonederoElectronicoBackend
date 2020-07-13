import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'

import ListCliente from '@/components/Clientes/ListCliente'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/clientes',
      name: 'ListCliente',
      component: ListCliente
    }
  ],
  mode: 'history'
})
