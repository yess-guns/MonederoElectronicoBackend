<template>
  <div>
    <Navbar :userData="userData" />
    <b-container>
      <b-row class="my-3">
        <b-col>
          <h1>Pagos</h1>
        </b-col>
      </b-row>
      <b-row align-h="end" class="mb-3">
        <b-col class="text-right">
          <b-button variant="secondary" @click="exportPDF()">Exportar PDF</b-button>  <b-button variant="success" @click="exportExcel()">Exportar Excel</b-button>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <template>
            <div>
              <b-table striped hover id="reportPagos" :items="dataPagos" :fields="filas" foot-clone>
                <template v-slot:cell(importeTotal)="row">
                  $ {{ row.value.toFixed(2) }}
                </template>
                <template v-slot:cell(porcentajePago)="row">
                  {{ row.value }} %
                </template>
                <template v-slot:cell(importeEfectivoTarjeta)="row">
                  $ {{ row.value.toFixed(2) }}
                </template>
                <template v-slot:cell(importeMonedeto)="row">
                  $ {{ row.value.toFixed(2) }}
                </template>

                <template v-slot:foot(fecha)="">
                  Total
                </template>
                <template v-slot:foot(folio)="">
                  {{ }}
                </template>
                <template v-slot:foot(importeTotal)="">
                  {{ total('importeTotal') }}
                </template>
                <template v-slot:foot(porcentajePago)="">
                  {{  }}
                </template>
                <template v-slot:foot(importeEfectivoTarjeta)="">
                  {{ total('importeEfectivoTarjeta') }}
                </template>
                <template v-slot:foot(importeMonedeto)="">
                  {{ total('importeMonedeto') }}
                </template>

              </b-table>
            </div>
          </template>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
  import Navbar from '@/components/Includes/Navbar'
  import { mapState, mapMutations } from 'vuex';
  import axios from 'axios';
  import jsPDF from 'jspdf'
  import 'jspdf-autotable'
  export default {
    name: 'Pagos',
    components: {
      Navbar
    },
    data () {
      return {
        dataPagos: [],
        fecha: '',
        filas: [
          { key: 'fecha', label: 'Fecha', sortDirection: 'desc', fott: 'Total' },
          { key: 'folio', label: 'Folio', sortDirection: 'desc' },
          { key: 'importeTotal', label: 'Importe', class: 'text-right' },
          { key: 'porcentajePago', label: 'Porcentaje', sortDirection: 'desc', class: 'text-right' },
          { key: 'importeEfectivoTarjeta', label: 'Importe efectivo/tarjeta', class: 'text-right' },
          { key: 'importeMonedeto', label: 'Importe monedero', class: 'text-right' }
        ]
      }
    },
    methods: {
      ...mapMutations(['validarSesion']),
      getPagosXdia(){
        const path = `${process.env.BASE_URI}cliente/getpagos/${this.fecha}/`
        axios.get(path).then((response) => {
          console.log(response.data)
          this.dataPagos = response.data.pagos
        })
      },
      exportPDF() {

        var doc = new jsPDF('p', 'pt');
        doc.text(`Reporte de pagos: ${this.fecha}`, 40, 35);

        doc.autoTable({ 
          html: '#reportPagos',
          margin: {top: 60}
        })
        doc.save(`reporte-pagos-${this.fecha}.pdf`);
      },
      total(campo){
        let total = 0
        switch (campo){
          case 'importeTotal':
            this.dataPagos.forEach(el => {
              total += el.importeTotal
            })
            return `$ ${total.toFixed(2)}`

          case 'importeEfectivoTarjeta':
            this.dataPagos.forEach(el => {
              total += el.importeEfectivoTarjeta
            })
            return `$ ${total.toFixed(2)}`

          case 'importeMonedeto':
            this.dataPagos.forEach(el => {
              total += el.importeMonedeto
            })
            return `$ ${total.toFixed(2)}`

          break
        }
      },
      exportExcel() {
        var downloadLink;
        var dataType = 'application/vnd.ms-excel';
        var tableSelect = document.getElementById('reportPagos');
        var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');

        // Specify file name
        let filename = `reporte-pagos-${this.fecha}.xls`;

        // Create download link element
        downloadLink = document.createElement("a");

        document.body.appendChild(downloadLink);

        if (navigator.msSaveOrOpenBlob) {
          var blob = new Blob(['ufeff', tableHTML], {
            type: dataType
          });
          navigator.msSaveOrOpenBlob(blob, filename);
        } else {
          // Create a link to the file
          downloadLink.href = 'data:' + dataType + ', ' + tableHTML;

          // Setting the file name
          downloadLink.download = filename;

          //triggering the function
          downloadLink.click();
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
          var date = new Date();
          var year = date.getFullYear();
          var month = date.getMonth()+1;
          var dt = date.getDate();

          if (dt < 10) {
            dt = '0' + dt;
          }
          if (month < 10) {
            month = '0' + month;
          }
          this.fecha = `${year}-${month}-${dt}`
          //this.fecha = '2020-07-25'
          this.getPagosXdia()
        }else{//es cajero
          this.$router.push('nuevo-pago')
        }
      }
    }
  }
</script>