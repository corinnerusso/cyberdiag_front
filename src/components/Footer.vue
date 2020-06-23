<template>
  <v-footer class="footer_container">
    <v-col class="footer_text" cols="12">
      <div class="subFooter">
        <router-link class="router-link" to="/">@copyrights 2020</router-link>
        <router-link class="router-link" to="/contact">Contact</router-link>
      </div>
      <div class="subFooter">
        <router-link class="router-link" to="/about">A propos</router-link>
        <router-link class="router-link" to="/legal-terms">Mentions Legales</router-link>
      </div>
    </v-col>
  </v-footer>
</template>

<script>
export default {
  name: "Footer"
};
</script>

<style scoped>
.footer_container {
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

.footer_text {
  background-image: url("../assets/plex-bleu.jpg") !important;
  color: white;
  display: flex;
  justify-content: center;
}

/* MEDIA QUERIES */
@media screen and (max-width: 640px) {
  .footer_text {
    font-size: 0.8rem;
  }

  .subFooter {
    display: flex;
    flex-direction: column;
    text-align: left;
  }
}
</style>
