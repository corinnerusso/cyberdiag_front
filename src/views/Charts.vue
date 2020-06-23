<template>
  <div class="survey">
    <div class="survey_title">
      <img
        :src="require('../assets/presentation.png')"
        height="50"
        width="70"
        contain
        style="padding-right:20px"
      />
      <h2>Titre : {{chartDatas[0].survey_surveyTitle}}</h2>
    </div>

    <v-tabs v-model="tabs" centered color="#162967">
      <v-tabs-slider color="#162967"></v-tabs-slider>
      <v-tab>Radar</v-tab>
      <v-tab>Cercle</v-tab>
    </v-tabs>
    <v-tabs-items v-model="tabs">
      <v-tab-item>
        <v-card flat>
          <v-card-text>
            <Radar v-bind:chartDatas="chartDatas" />
          </v-card-text>
        </v-card>
      </v-tab-item>
      <v-tab-item>
        <v-card flat>
          <v-card-text>
            <Radial v-bind:chartDatas="chartDatas" />
          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </div>
</template>

<script>
import Radar from "@/components/Radar.vue";
import Radial from "@/components/Radial.vue";

import axios from "axios";

export default {
  name: "Charts",

  components: {
    Radar,
    Radial
  },
  data() {
    return {
      tabs: null,
      right: true,
      chartDatas: []
    };
  },
  created() {
    this.getDatasForCharts();
  },
  beforeMount() {
    this.getDatasForCharts();
  },

  mounted() {
    this.getDatasForCharts;
  },

  methods: {
    getDatasForCharts() {
      axios
        .get(`http://localhost:3005/submit/` + this.$route.params.id)
        .then(response => {
          this.chartDatas.push(...response.data);
        })
        .catch(e => {
          console.log(e);
        });
    }
  }
};
</script>

<style scoped>
.survey_title {
  margin: 1%;
  color: #162967;
  display: flex;
}
.survey {
  padding-left: 10%;
  padding-right: 10%;
  margin-top: 100px;
}
</style>
