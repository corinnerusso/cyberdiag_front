<template>
  <div>
    <v-app-bar app color="primary">
      <div class="d-flex align-center">
        <v-img
          :src="require('../assets/security.svg')"
          class="my-3"
          contain
          height="200"
          transition="scale-transition"
          width="40"
        />

        <router-link to="/home" class="home_router_link">CYBERDIAG</router-link>
      </div>

      <v-spacer></v-spacer>

      <v-avatar class="avatar_pic" color="orange darken-3">
        <v-icon dark>mdi-account-circle</v-icon>
      </v-avatar>

      <v-menu offset-y>
        <template v-slot:activator="{ on }">
          <v-btn color="primary" dark v-on="on">No one ▼</v-btn>
        </template>
        <v-list>
          <v-list-item v-for="(item, index) in items" :key="index" :to="item.link" link>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>
  </div>
</template>

<script>
export default {
  name: "Navbar",
  data: () => ({
    items: [{ title: "Mon compte", link: "/account" }, { title: "Deconnexion" }]
  })
};
</script>

<style scoped>
.v-application .primary {
  background-image: linear-gradient(to right, #56b1c8, #175a77) !important;
  color: white;
}

/* CYBERDIAG BACK HOME */
.home_router_link {
  text-decoration: none;
  color: white;
  font-size: 2rem;
  padding-left: 1vw;
}

/* PROFILE PIC */
.avatar_pic {
  height: 45px !important;
  min-width: 45px;
  width: 45px;
  margin: 2%;
}
</style>
