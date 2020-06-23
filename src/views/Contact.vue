<template>
  <div class="contact_container">
    <v-card class="d-inline-block mx-auto">
      <h2>CYBERENS</h2>

      <v-container>
        <v-row justify="space-between">
          <v-col cols="auto">
            <v-img height="200" width="400" src="../assets/cadenas.jpg"></v-img>
          </v-col>
        </v-row>
      </v-container>

      <div>
        <v-btn icon>
          <a class="href" href="https://twitter.com/Cyberens_fr" target="_blank">
            <v-icon color="black">mdi-twitter</v-icon>
          </a>
        </v-btn>
        <v-btn icon>
          <a class="href" href="https://cyberens.fr" target="_blank">
            <v-icon color="black">double_arrow</v-icon>
          </a>
        </v-btn>
      </div>
      <div class="details">
        <v-icon class="v-icon">place</v-icon>Tour 6 - 74 rue Georges Bonnac - 33000 BORDEAUX
      </div>

      <div class="details">
        <v-icon class="v-icon">phone</v-icon>+33 5 56 58 62 45
      </div>

      <div class="details">
        <v-icon class="v-icon">email</v-icon>info@cyberens.fr
      </div>
    </v-card>
  </div>
</template>

<script>
export default {
  name: "Contact"
};
</script>

<style scoped>
.contact_container {
  margin-top: 100px;
}
.details {
  display: flex;
  padding: 20px;
  text-align: left;
}

.href {
  text-decoration: none;
}

.v-icon {
  padding-right: 10px;
  color: black;
}

/* MEDIA QUERIES */
@media screen and (max-width: 640px) {
  .details {
    font-size: 0.9rem;
    line-height: 0.9rem;
  }
}
</style>