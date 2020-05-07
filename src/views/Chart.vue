<template>
  <div style="margin-top:100px" class="home">
    <ChartPage />
  </div>
</template>

<script>
import ChartPage from "@/components/ChartPage.vue";

export default {
  name: "Chart",
  components: {
    ChartPage
  }
};
</script>

<style scoped>
.home {
  padding-left: 10%;
  padding-right: 10%;
}
</style>