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
          <v-btn color="primary" dark v-on="on">{{myProfile}} ▼</v-btn>
        </template>
        <v-list>
          <v-list-item :to="`/account`">Mon compte</v-list-item>
          <v-list-item @click="disconnected">Deconnexion</v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>
  </div>
</template>

<script>
export default {
  name: "Navbar",
  data: () => ({
    myProfile: "",
    role: "",
    isConnected: true
  }),

  methods: {
    disconnected() {
      this.isConnected = false;
      this.token = JSON.parse(localStorage.removeItem("jwt"));
    },
    connected() {
      this.isConnected = !this.isConnected;
      console.log("hi");
    },

    profileRole() {
      const userStatus = JSON.parse(localStorage.getItem("user"));
      if (userStatus.user.role === "user") {
        this.role = "User";
      } else {
        this.role = "Admin";
      }
      this.myProfile = userStatus.user.lastname;
    },
    checkProfileStatus() {
      const userStatus = JSON.parse(localStorage.getItem("user"));
      if (userStatus.user.activated !== false) {
        this.isConnected = true;
      } else {
        this.isConnected = false;
      }
    }
  },

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
    this.profileRole();
    this.checkProfileStatus();
  }
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
  min-width: 44px;
  width: 44px;
  margin: 2%;
}

.v-icon.v-icon {
  font-size: 30px;
}
</style>
