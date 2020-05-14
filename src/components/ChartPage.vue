/* eslint-disable prettier/prettier */
<template class="radarStyle">
  <div>
    page de graphique
    <p>Nom du questionnaire : {{ currentData[0].survey_surveyTitle }}</p>
    <p>topic Title : {{topicTitle}}</p>

    <div v-for="(data, index) in topicTitle" v-bind:key="index">
      <p>{{data}}</p>
    </div>

    <p>---------------------------------</p>
    <div id="chart">
      <apexchart type="radar" height="600" :options="chartOptions" :series="series"></apexchart>
    </div>
    <br />
    <br />
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "ChartPage",
  data: () => ({
    currentData: [],

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
      topicTitle: [],
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
        categories: []
      }
    }
  }),

  mounted() {
    axios
      .get(`http://localhost:3005/submit/` + this.$route.params.id)
      .then(response => {
        let topicTitle = this.chartOptions.xaxis.categories;
        this.currentData = response.data;
        topicTitle = this.currentData.map(
          x => topicTitle.push(x.survey_topicTitle),
          console.log("topicTitle", this.chartOptions.xaxis.categories)
        );
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
