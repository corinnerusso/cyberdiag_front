<template>
  <div>
    page de graphique
    <p>Nom du questionnaire : {{currentCharts.survey_title}}</p>
    <div v-for="(currentChart, index) in currentChart" v-bind:key="index">fg</div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "ChartPage",
  data: () => ({
    currentCharts: []
  }),

  beforeMount() {
    axios
      .get(`http://localhost:3005/surveys/` + this.$route.params.id)
      .then(response => {
        this.currentCharts = response.data;
        console.log("page chart", response.data);
      })
      .catch(e => {
        console.log(e);
      });
  }
};
</script>