<template>
  <div style="margin-top:100px" class="home">
    <HomePage />
    <MySurvey />
  </div>
</template>

<script>
// @ is an alias to /src
import HomePage from "@/components/HomePage.vue";
import MySurvey from "@/components/MySurvey.vue";

export default {
  name: "Home",
  components: {
    HomePage,
    MySurvey
  }
};
</script>

<style scoped>
.home {
  padding-left: 10%;
  padding-right: 10%;
}
</style>
