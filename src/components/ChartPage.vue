/* eslint-disable prettier/prettier */
<template class="radarStyle">
  <div>
    page de graphique
    <p>Nom du questionnaire : {{ currentCharts.survey_title }}</p>
    <div v-for="(currentChart, index) in currentChart" v-bind:key="index">fg</div>
    <div id="chart">
      <apexchart type="radar" height="600" :options="chartOptions" :series="series"></apexchart>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "ChartPage",
  data: () => ({
    currentCharts: [],
    series: [
      {
        name: "Niveau maximal",
        data: [36, 16, 16, 14]
      },
      {
        name: "Résultat",
        data: [20, 10, 5, 12]
      }
    ],

    chartOptions: {
      chart: {
        height: 250,
        type: "radar",
        dropShadow: {
          enabled: true,
          blur: 2,
          left: 2,
          top: 2
        }
      },
      // title: {
      //   text: "Radar Chart - Multi Series"
      // },
      stroke: {
        width: 3
      },
      fill: {
        opacity: 0.1
      },
      markers: {
        size: 0
      },
      xaxis: {
        categories: [
          "Sécurité des systèmes d'information",
          "Sécurité des réseaux",
          "Facteur humain",
          "Incidents et gestion de crise"
        ]
      }
    }
  }),

  beforeMount() {
    axios
      .get(`http://localhost:3005/surveys/` + this.$route.params.id)
      .then(response => {
        this.currentCharts = response.data;
        this.categories = response.data.topics;
        console.log("page chart", response.data.company.models);
      })
      .catch(e => {
        console.log(e);
      });
  }
};
</script>

<style scoped>
.radarStyle {
  padding-top: 100px !important;
}
</style>
