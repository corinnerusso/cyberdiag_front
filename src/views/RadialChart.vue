<template>
  <div style="margin-top:100px" class="home">
    <RadialChartPage v-bind:chartDatas="chartDatas" />
  </div>
</template>

<script>
import RadialChartPage from "@/components/RadialChartPage.vue";
import axios from "axios";
export default {
  name: "RadialChart",

  components: {
    RadialChartPage
  },

  data() {
    return {
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
.home {
  padding-left: 10%;
  padding-right: 10%;
}
</style>