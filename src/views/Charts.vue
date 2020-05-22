<template>
  <div style="margin-top:100px;color:black;" class="survey">
    <v-tabs v-model="tabs" centered>
      <v-tab>Spider</v-tab>
      <v-tab>Radial</v-tab>
    </v-tabs>
    <v-tabs-items v-model="tabs">
      <v-tab-item>
        <v-card flat>
          <ChartPage />
        </v-card>
      </v-tab-item>
      <v-tab-item>
        <v-card flat>
          <v-card-title class="headline">An awesome title</v-card-title>
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
import ChartPage from "@/components/ChartPage.vue";
import Radial from "@/components/Radial.vue";

import axios from "axios";
export default {
  name: "Charts",

  components: {
    ChartPage,
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
