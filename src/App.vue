<template>
  <v-app>
    <v-app-bar app color="primary" dark>
      <div class="d-flex align-center">
        <v-img
          :src="require('./assets/security.svg')"
          class="my-3"
          contain
          height="200"
          transition="scale-transition"
          width="40"
        />
        <span class="create">CYBERDIAG</span>
      </div>

      <v-spacer></v-spacer>

      <v-btn
        class="navbar-button"
        href="https://github.com/vuetifyjs/vuetify/releases/latest"
        target="_blank"
        text
      >
        <div class="d-flex align-center">
          <i class="material-icons">
            create
          </i>
        </div>
        <span class="mr-2">Créer un nouveau questionnaire</span>
      </v-btn>
      <div>
        <i class="material-icons" color="black">
          perm_identity
        </i>
      </div>
      <v-col cols="12" sm="1">
        <v-overflow-btn
          class="my-2"
          :items="dropdown_choice"
          target="#dropdown-example"
        ></v-overflow-btn>
      </v-col>
    </v-app-bar>

    <v-content>
      <HelloWorld />
    </v-content>
    <div id="app">
      <v-app id="inspire">
        <v-footer padless>
          <v-col class="text-center" cols="12">
            {{ new Date().getFullYear() }} — <strong>Vuetify</strong>
          </v-col>
        </v-footer>
      </v-app>
    </div>
  </v-app>
</template>

<script>
import HelloWorld from "./components/HelloWorld";

export default {
  name: "App",

  components: {
    HelloWorld
  },

  data: () => ({
    dropdown_choice: [{ text: "Mon compte" }, { text: "Deconnexion" }]
  })
};
</script>

<style scoped>
.v-application .primary {
  background-color: #165874 !important;
}

.create {
  font-size: 1.7em;
  margin-left: 10%;
}

.navbar-button {
  background-color: #38718a;
  box-shadow: 0 4px 25px 0 rgba(0, 0, 0, 0.1);
}
</style>
