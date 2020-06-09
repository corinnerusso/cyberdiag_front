<template>
  <div>
    <v-footer class="footer">
      <v-col class="text-center" cols="12">
        @copyrights
        {{ new Date().getFullYear() }}
        <router-link class="router-link" to="/contact">Contact</router-link>
        <router-link class="router-link" to="/about">A propos</router-link>
        <router-link class="router-link" to="/legal-terms">Mentions Legales</router-link>
      </v-col>
    </v-footer>
  </div>
</template>

<script>
export default {
  name: "Footer"
};
</script>

<style scoped>
.footer {
  position: absolute;
  bottom: 0;
  right: 0;
  left: 0;
  padding: 0;
}

.router-link {
  color: white;
  text-decoration: none;
  padding-left: 7vw;
}

.text-center {
  /* display: flex;
  justify-content: space-around; */
  background-image: linear-gradient(to right, #56b1c8, #175a77) !important;
  color: white;
}
</style>
