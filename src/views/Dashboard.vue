<template>
  <div style="margin-top:100px">
    <v-data-table :headers="headers" :items="users" sort-by="cie_name" class="elevation-1">
      <template v-slot:top>
        <v-toolbar flat color="white">
          <v-toolbar-title>DASHBOARD</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-spacer></v-spacer>
          <v-dialog v-model="dialog" max-width="500px">
            <!-- comments button" -->
            <template v-slot:activator="{ on }">
              <v-btn color="primary" dark class="mb-2" v-on="on">Ajouter commentaires</v-btn>
            </template>
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
                <v-btn color="blue darken-1" text @click="close">Cancel</v-btn>
                <v-btn color="blue darken-1" text @click="save()">Save</v-btn>
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

    users: [],
    errors: [],
    hasSurvey: [],
    field: "test",

    currentUser: null,
    currentIndex: -1,

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
      { text: "A rempli un questionnaire", value: "surveys[0].id" },
      { text: "Commentaires", value: "comments" },
      { text: "Actions", value: "actions", sortable: false }
    ],

    editedIndex: -1,
    editedItem: {
      ok: "",
      comments: ""
    }
  }),

  created() {
    this.getAllUsers();
  },

  mounted() {
    // this.surveyExist();
  },

  watch: {
    dialog(val) {
      val || this.close();
    }
  },

  methods: {
    editItem(item) {
      this.editedIndex = this.users.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },
    getAllUsers() {
      axios
        .get(`http://localhost:3005/users/dashboard`)
        .then(response => {
          this.users = response.data;
          console.log("response.data", response.data);
        })
        .catch(e => {
          this.errors.push(e);
        });
    },

    setActiveUser(user, index) {
      this.currentUser = user;
      this.currentIndex = index;
    },

    // close() {
    //   this.dialog = false;
    //   this.$nextTick(() => {
    //     this.editedItem = Object.assign({}, this.defaultItem);
    //     this.editedIndex = -1;
    //   });
    // },

    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedIndex = -1;
      }, 300);
    },

    save() {
      if (this.editedIndex > -1) {
        axios
          .put(`http://localhost:3005/users/` + this.editedItem.userId, {
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