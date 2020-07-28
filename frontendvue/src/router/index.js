import Vue from 'vue'
import Router from 'vue-router'
import NewPago from '@/components/PagoDescuento/NewPago'

import ListCliente from '@/components/Clientes/ListCliente'
import PagosCliente from '@/components/Clientes/PagosCliente'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/nuevo-pago',
      name: 'NewPago',
      component: NewPago
    },
    {
      path: '/clientes',
      name: 'ListCliente',
      component: ListCliente
    },
    {
      path: '/clientes/:clienteId/pagos',
      name: 'PagosCliente',
      component: PagosCliente
    }
  ],
  mode: 'history'
})
