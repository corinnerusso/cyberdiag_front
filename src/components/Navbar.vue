<template>
  <div>
    <v-app-bar app color="primary">
      <!-- If the user is connected, the logo and text CYBERDIAG displays homepage
      -->
      <div v-if="connectedUser" class="d-flex align-center">
        <router-link to="/home" class="home_router_link_logo">
          <v-img
            :src="require('../assets/Logo-triangle.png')"
            contain
            height="400"
            transition="scale-transition"
            width="80"
          />
        </router-link>

        <router-link to="/home" class="home_router_link2">CYBERDIAG</router-link>
      </div>
      <!-- If the user is not connected, it displays login page -->
      <div v-else class="d-flex align-center">
        <router-link to="/" class="home_router_link_logo">
          <v-img
            :src="require('../assets/Logo-triangle.png')"
            contain
            height="400"
            transition="scale-transition"
            width="80"
          />
        </router-link>

        <router-link to="/" class="home_router_link2">CYBERDIAG</router-link>
      </div>

      <v-spacer></v-spacer>
      <!-- User menu -->
      <v-menu v-if="connectedUser" offset-y>
        <template v-slot:activator="{ on }">
          <v-btn class="navbar_menu" v-on="on">{{myProfile}} ▼</v-btn>
        </template>
        <v-list>
          <v-list-item :to="`/account`">Mon compte</v-list-item>
          <router-link class="connect_router_link" to="/">
            <v-list-item @click="(userDisconnection())">Deconnexion</v-list-item>
          </router-link>
        </v-list>
      </v-menu>
    </v-app-bar>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "Navbar",
  data: () => ({
    myProfile: "",
    role: "",
    connectedUser: "",
    isConnected: true,
    isUserId: ""
  }),

  computed: {
    showAdmin() {
      let user = JSON.parse(localStorage.getItem("user"));
      let show = true;

      if (user.user.is_admin !== 1 || user.user.role !== "admin") {
        show = false;
      }

      return show;
    }
  },
  created() {
    this.setUserId();
    this.checkConnection();
    this.profileRole();
    this.checkProfileStatus();
  },

  updated() {
    this.setUserId();
    this.checkConnection();
  },
  methods: {
    //retrieve user id
    setUserId() {
      this.storageUser = JSON.parse(localStorage.getItem("user"));
      this.isUserId = this.storageUser.user.id;
    },

    //check if the user is connected
    //If user is connected, show user menu, if not, don't show it
    checkConnection() {
      axios
        .get(`http://localhost:3005/users/` + this.isUserId)
        .then(response => {
          this.connectedUser = response.data.connected;
        });
    },

    //check user profile
    profileRole() {
      const userStatus = JSON.parse(localStorage.getItem("user"));
      if (userStatus.user.role === "user") {
        this.role = "User";
      } else {
        this.role = "Admin";
      }
      this.myProfile = userStatus.user.firstname;
    },

    //check user status

    checkProfileStatus() {
      const userStatus = JSON.parse(localStorage.getItem("user"));
      if (userStatus.user.connected !== false) {
        this.isConnected = true;
      } else {
        this.isConnected = false;
      }
    },

    //disconnection
    userDisconnection() {
      // this.isConnected = false;
      localStorage.clear();
      axios
        .put(`http://localhost:3005/users/` + this.isUserId, {
          connected: false
        })
        .then(response => {
          console.log(response);
        });
    }
  }
};
</script>

<style scoped>
/* NAVBAR BACKGROUND */
.v-application .primary {
  background-image: url("../assets/plex-bleu.jpg") !important;
  color: white;
}

/* CYBERDIAG LOGO AND TEXT */
.home_router_link_logo {
  text-decoration: none;
  color: white;
  font-size: 2rem;
  padding-left: 1vw;
}

.home_router_link2 {
  text-decoration: none;
  color: white;
  font-size: 2rem;
  padding-left: 1vw;
}

.connect_router_link {
  text-decoration: none !important;
}

.navbar_menu {
  color: #263a74 !important;
}

/* MEDIA QUERIES */
@media screen and (max-width: 640px) {
  .home_router_link2 {
    display: none;
  }
}
</style>
