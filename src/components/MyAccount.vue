<template>
  <div style="margin-top:100px; margin-left:2%; margin-right:2%">
    <!-- <div class="account_detail">Détail du compte</div>
    <div class="account_input">
      <p>email</p>
      <p>{{userDatas.email}}</p>

      <button>Modifier</button>
    </div>

    <div class="account_input">
      <p>Mot de passe</p>
      <p>**************</p>
      <button>Modifier</button>
    </div>
    <div>
      <button class="account_end_button">
        <router-link class="router-link" to="/home">Terminer</router-link>
      </button>
    </div>-->
    <!-- *********************************************** -->
    <v-data-table :headers="headers" :items="userDatas" class="elevation-1">
      <template v-slot:top>
        <v-toolbar flat color="white">
          <v-toolbar-title>MON COMPTE</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-spacer></v-spacer>
          <v-dialog v-model="dialog" max-width="500px">
            <v-card>
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col cols="12" sm="12" md="40">
                      <v-text-field v-model="editedItem.lastname" label="Nom"></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="12" md="40">
                      <v-text-field v-model="editedItem.firstname" label="Prénom"></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="12" md="40">
                      <v-text-field v-model="editedItem.phone_number" label="N° tel"></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="12" md="40">
                      <v-text-field v-model="editedItem.email" label="email"></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="12" md="40">
                      <v-text-field v-model="editedItem.password" label="Mot de passe"></v-text-field>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="close">Cancel</v-btn>
                <v-btn color="blue darken-1" text @click="save">Save</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-toolbar>
      </template>
      <template v-slot:item.actions="{ item }">
        <v-icon small class="mr-2" @click="editItem(item)">mdi-pencil</v-icon>
      </template>
    </v-data-table>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "MyAccount",

  props: {
    userDatas: {
      type: Array,
      required: true
    },
    isUserId: {
      type: null,
      required: true
    }
  },

  data: () => ({
    dialog: false,
    headers: [
      {
        text: "Nom",
        align: "start",
        sortable: false,
        value: "lastname"
      },
      { text: "Prénom", value: "firstname" },
      { text: "N° tel", value: "phone_number" },
      { text: "email", value: "email" },
      { text: "Mot de passe", value: "password" },
      { text: "Actions", value: "actions", sortable: false }
    ],

    editedIndex: -1,
    editedItem: {
      lastname: "",
      firstname: "",
      phone_number: "",
      email: "",
      password: ""
    }
  }),

  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "New Item" : "Edit Item";
    }
  },

  watch: {
    dialog(val) {
      val || this.close();
    }
  },

  methods: {
    editItem(item) {
      this.editedIndex = this.userDatas.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    deleteItem(item) {
      const index = this.userDatas.indexOf(item);
      confirm("Are you sure you want to delete this item?") &&
        this.userDatas.splice(index, 1);
    },

    close() {
      this.dialog = false;
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      });
    },

    save() {
      if (this.editedIndex > -1) {
        axios
          .put(`http://localhost:3005/users/` + this.isUserId, {
            firstname: this.editedItem.firstname,
            lastname: this.editedItem.lastname,
            phone_number: this.editedItem.phone_number,
            email: this.editedItem.email,
            password: this.editedItem.password
          })
          .then(response => {
            console.log(response);
          });

        Object.assign(this.userDatas[this.editedIndex], this.editedItem);
      } else {
        this.userDatas.push(this.editedItem);
      }
      this.close();
    }
  }
};
</script>

<style scoped>
.v-text-field {
  width: 50%;
}
.account_detail {
  background-color: #4ca3bb;
  text-align: start;
  margin: 0 10% 0 10%;
  padding: 1.2vw;
  color: white;
  font-weight: bold;
}

.account_input {
  display: flex;
  background-color: white;
  text-align: start;
  margin: 0 10% 0 10%;
  padding: 1.2vw;
  color: black;
  justify-content: space-between;
  border: 0.1rem solid grey;
}

/* MODIFY BUTTON */

/* END BUTTON */
.account_end_button {
  margin-top: 2vw;
  padding: 0.8vw 1.5vw 0.8vw 1.5vw;
  border-radius: 5px;
}

.router-link {
  color: white;
  text-decoration: none;
}
</style>
