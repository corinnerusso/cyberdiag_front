<template>
  <div style="margin-top:100px; margin-left:2%; margin-right:2%">
    <v-data-table
      :search="search"
      :headers="headers"
      :items="users"
      :items-per-page="50"
      sort-by="cie_name"
      class="elevation-1"
    >
      <template v-slot:top>
        <v-toolbar flat color="white">
          <v-toolbar-title class="v-card-title">DASHBOARD</v-toolbar-title>

          <v-card-title class="search_field">
            <v-text-field v-model="search" append-icon="mdi-magnify" label="Chercher" hide-details></v-text-field>
          </v-card-title>

          <v-divider class="mx-4" inset vertical></v-divider>
          <v-spacer></v-spacer>
          <v-dialog v-model="dialog" max-width="500px">
            <v-card>
              <!-- MODAL -->
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col cols="12" sm="600" md="200">
                      <v-text-field v-model="editedItem.comments" label="Commentaires"></v-text-field>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="close">Annuler</v-btn>
                <v-btn color="blue darken-1" text @click="save">Sauvegarder</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-toolbar>
      </template>
      <template v-slot:item.actions="{ item }">
        <v-icon
          small
          class="mr-2"
          @click="editItem(item)"
          title="Modifier les commentaires"
        >mdi-pencil</v-icon>
      </template>
    </v-data-table>
  </div>
</template>


<script>
import axios from "axios";
export default {
  name: "Dashboard",
  data: () => ({
    dialog: false,
    search: "",
    users: [],
    errors: [],
    isUserId: "",
    connectect: "",
    headers: [
      {
        text: "Nom entreprise",
        align: "start",
        sortable: false,
        value: "cie_name"
      },
      { text: "Nom", value: "lastname" },
      { text: "Prénom", value: "firstname" },
      { text: "Email", value: "email" },
      { text: "Phone", value: "phone_number" },
      { text: "Date de création", value: "user_creation_date" },
      { text: "A rempli un questionnaire", value: "surveys[0].has_a_survey" },
      { text: "Role", value: "role" },
      { text: "Commentaires", value: "comments" },
      { text: "Ajouter/modifier", value: "actions", sortable: false }
    ],

    editedIndex: -1,
    editedItem: {
      comments: ""
    }
  }),

  created() {
    this.getAllUsers();
    this.setUserId();
    this.userConnection();
  },

  watch: {
    dialog(val) {
      val || this.close();
    }
  },

  methods: {
    //set user id
    setUserId() {
      this.storageUser = JSON.parse(localStorage.getItem("user"));
      this.isUserId = this.storageUser.user.id;
    },

    //set connected from false to true when a user is connected
    userConnection() {
      axios
        .put(`http://localhost:3005/users/` + this.isUserId, {
          connected: true
        })
        .then(response => {
          console.log(response);
        });
    },

    editItem(item) {
      this.editedIndex = this.users.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    //get datas for all users
    getAllUsers() {
      axios
        .get(`http://localhost:3005/users`)
        .then(response => {
          this.users = response.data;
        })
        .catch(e => {
          this.errors.push(e);
        });
    },

    //******** MODAL OPTIONS ********* */

    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedIndex = -1;
      }, 300);
    },

    save() {
      if (this.editedIndex > -1) {
        axios
          .put(`http://localhost:3005/users/` + this.editedItem.id, {
            comments: this.editedItem.comments
          })
          .then(response => {
            console.log(response);
          });

        Object.assign(this.users[this.editedIndex], this.editedItem);
        this.close();
      }
    }
  }
};
</script>

<style scoped>
.v-card-title {
  width: 10% !important;
  text-align: left;
}

.search_field {
  width: 40% !important;
}
</style>