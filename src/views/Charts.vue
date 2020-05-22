<template>
  <div style="margin-top:100px;color:black;" class="survey">
    <v-tabs v-model="tabs" centered>
      <v-tab>Radar</v-tab>
      <v-tab>Cercle</v-tab>
    </v-tabs>
    <v-tabs-items v-model="tabs">
      <v-tab-item>
        <v-card flat>
          <v-card-title class="headline">Titre : {{chartDatas[0].survey_surveyTitle}}</v-card-title>
          <v-card-text>
            <Radar v-bind:chartDatas="chartDatas" />
          </v-card-text>
        </v-card>
      </v-tab-item>
      <v-tab-item>
        <v-card flat>
          <v-card-title class="headline">Titre : {{chartDatas[0].survey_surveyTitle}}</v-card-title>
          <v-card-text>
            <Radial v-bind:chartDatas="chartDatas" />
          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </div>
</template>

<script>
// @ is an alias to /src
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
      chartDatas: []
    };
  },

  beforeCreate() {
    axios
      .get(`http://localhost:3005/submit/` + this.$route.params.id)
      .then(response => {
        this.chartDatas.push(...response.data);
      })
      .catch(e => {
        console.log(e);
      });
  }
};
</script>

<style scoped>
.survey {
  padding-left: 10%;
  padding-right: 10%;
}
</style>
