/* eslint-disable prettier/prettier */
<template>
  <div>
    <p>{{currentData[0].survey_surveyTitle}}</p>
    <div id="chart">
      <apexchart type="radar" height="700" :options="chartOptions" :series="series"></apexchart>
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
        data: []
      },
      {
        name: "Résultat",
        data: []
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

      stroke: {
        show: false
      },
      fill: {
        opacity: 0.1
      },
      markers: {
        size: 0
      },
      xaxis: {
        categories: [],
        labels: {
          show: true,
          style: {
            fontSize: "0.8rem",
            fontWeight: 700
          }
        }
      },

      dataLabels: {
        enabled: true,
        background: {
          enabled: true,
          borderRadius: 2
        }
      }
    }
  }),

  beforeCreate() {
    axios
      .get(`http://localhost:3005/submit/` + this.$route.params.id)
      .then(response => {
        this.currentData = response.data;
        //set topic labels
        let topicTitle = this.chartOptions.xaxis.categories;
        topicTitle = this.currentData.map(el =>
          topicTitle.push(el.survey_topicTitle)
        );

        //set max quote
        let maxQuote = this.series[0].data;
        maxQuote = this.currentData.map(el =>
          maxQuote.push(el.survey_topicQuote)
        );

        // set current survey quote
        let surveyQuote = this.series[1].data;
        surveyQuote = this.currentData.map(el => surveyQuote.push(el.sum));
      })
      .catch(e => {
        console.log(e);
      });
  }
};
</script>

<style scoped>
</style>
