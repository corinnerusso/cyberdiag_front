<template>
  <v-app id="app">
    <Navbar />

    <router-view></router-view>
    <Footer />
  </v-app>
</template>

<script>
import Navbar from "@/components/Navbar.vue";
import Footer from "@/components/Footer.vue";

export default {
  name: "App",

  components: {
    Navbar,
    Footer
  }
};
</script>

<style scoped>
#app {
  text-align: center;
  background-color: #f5f8fa;
  display: flex;
  justify-content: center;
}
</style>


