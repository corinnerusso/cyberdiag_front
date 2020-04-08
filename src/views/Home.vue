<template>
  <div style="margin-top:100px" class="home">
    <HomePage />
    <MySurvey />
    <Test :info="infos"></Test>
  </div>
</template>

<script>
// @ is an alias to /src
import HomePage from "@/components/HomePage.vue";
import MySurvey from "@/components/MySurvey.vue";
import Test from "@/components/Test.vue";

export default {
  name: "Home",
  components: {
    HomePage,
    MySurvey,
    Test
  },

  data() {
    return {
      infos: [
        {
          id: 1,
          message: "info numero 1"
        },
        {
          id: 2,
          message: "info numero 2"
        }
      ]
    };
  }
};
</script>

<style scoped>
.home {
  padding-left: 10%;
  padding-right: 10%;
}
</style>
