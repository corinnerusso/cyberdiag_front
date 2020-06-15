<template>
  <div class="contact_container">
    <v-card class="d-inline-block mx-auto">
      <h1>CYBERENS</h1>

      <v-container>
        <v-row justify="space-between">
          <v-col cols="auto">
            <v-img height="200" width="400" src="../assets/cadenas.jpg"></v-img>
          </v-col>

          <v-col cols="auto" class="text-center pl-0">
            <v-row class="flex-column ma-0 fill-height" justify="center">
              <v-col class="px-0">
                <v-btn icon>
                  <a href="https://twitter.com/Cyberens_fr" target="_blank">
                    <v-icon color="black">mdi-twitter</v-icon>
                  </a>
                </v-btn>
              </v-col>

              <v-col class="px-0">
                <v-btn icon>
                  <a href="https://cyberens.fr" target="_blank">
                    <v-icon color="black">double_arrow</v-icon>
                  </a>
                </v-btn>
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-container>
      <div class="details">
        <v-icon class="v-icon">place</v-icon>Tour 6 - 74 rue Georges Bonnac - 33000 BORDEAUX
      </div>

      <div class="details">
        <v-icon class="v-icon">phone</v-icon>+33 0 01 74 13 54
      </div>

      <div class="details">
        <v-icon class="v-icon">email</v-icon>bernard.roussely@cyberens.fr
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
}

.v-icon {
  padding-right: 10px;
  color: black;
}
</style>