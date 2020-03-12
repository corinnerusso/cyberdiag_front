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

      <v-btn class="navbar-button" href target="_blank" text>
        <div class="d-flex align-center">
          <i class="material-icons">create</i>
        </div>
        <span class="mr-2">Créer un nouveau questionnaire</span>
      </v-btn>

      <div class="dropdown">
        <button class="dropbtn">
          <div class="profile_picture">
            <i class="material-icons">perm_identity</i>
          </div>

          <!-- POSSIBLE AVATAR FROM VUETIFY -->
          <!-- <v-avatar color="indigo">
            <v-icon dark>mdi-account-circle</v-icon>
          </v-avatar> -->
          <div>M. Nobody ▼</div>
        </button>
        <div class="dropdown-content">
          <router-link to="/account">Mon compte</router-link>
          <router-link to="#">Deconnexion</router-link>
        </div>
      </div>
    </v-app-bar>
  </div>
</template>

<script>
export default {
  name: "Navbar"
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

/* TEMPORARY ICON */
.create {
  font-size: 1.7em;
  margin-left: 10%;
}

.navbar-button {
  background-color: #38718a;
  box-shadow: 0 4px 25px 0 rgba(0, 0, 0, 0.1);
  color: white !important;
}

.mr-2 {
  color: white !important;
  margin-left: 2%;
}

/* PROFILE PIC */

.profile_picture {
  width: 4vw;
}

/* DROPDOWN BUTTON  */
.dropbtn {
  color: white;
  padding: 18px 25px 20px 18px;
  font-size: 16px;
  border: none;
  cursor: pointer;
  display: flex;
  margin-left: 3vw;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  z-index: 1;
  margin-left: 3vw;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {
  background-color: #f1f1f1;
}

.dropdown:hover .dropdown-content {
  display: block;
}

.dropdown:hover .dropbtn {
  background-color: #3e8e41;
}
</style>
