<template>
  <div style="margin-top:100px" class="home">
    <HomePage />
  </div>
</template>

<script>
import HomePage from "@/components/HomePage.vue";

export default {
  name: "Home",
  components: {
    HomePage
  },

  data() {
    return {};
  }
};
</script>

<style scoped>
.home {
  padding-left: 10%;
  padding-right: 10%;
}
</style>
