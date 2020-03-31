<template>
  <v-data-table :headers="headers" :items="surveys" sort-by="client" class="elevation-1">
    <template v-slot:top>
      <p>BARRE DE RECHERCHE</p>
      <v-toolbar color="#4CA3BB">
        <v-toolbar-title style="color:white">MES QUESTIONNAIRES</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-dialog v-model="dialog" max-width="500px">
          <!-- boutton "nouveau questionnaire" -->
          <template v-slot:activator="{ on }">
            <v-btn color="#40778f" dark class="mb-2" v-on="on">Nouveau questionnaire</v-btn>
          </template>

          <v-card>
            <!-- MODAL -->
            <v-card-text>
              <v-container>
                <v-row>
                  <!-- "Questinnaire" input dans la modal -->
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.name" label="Questionnaire">fdgfghfgj</v-text-field>
                  </v-col>

                  <!-- "Nom du client" input dans la modal -->
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.client" label="Client"></v-text-field>
                  </v-col>
                  <!-- "Créé le" input dans la modal -->
                  <v-col cols="12" sm="6" md="4">
                    <span>Crée le</span>
                    <br />
                    <input type="date" v-model="editedItem.created" label="Créé le" />
                  </v-col>
                  <!-- "Type d'entreprise" input dans la modal -->
                  <v-col cols="12" sm="6" md="4">
                    <v-overflow-btn
                      v-model="editedItem.type"
                      :items="items"
                      label="Type d'entreprise"
                    ></v-overflow-btn>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>
            <!-- Bouttons Annuler et Sauvegarder dans la modal -->
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="close">Annuler</v-btn>
              <v-btn color="blue darken-1" text @click="save">Sauvegarder</v-btn>
            </v-card-actions>
            <!-- FIN DE LA MODAL -->
          </v-card>
        </v-dialog>
      </v-toolbar>
    </template>
    <!-- ACTIONS -->
    <template v-slot:item.actions="{ item }">
      <router-link class="router-link" to="/Survey">→</router-link>
      <v-icon small title="Voir les résultats">trending_up</v-icon>
      <v-icon
        small
        class="mr-2"
        @click="editItem(item)"
        title="Modifier le questionnaire"
      >mdi-pencil</v-icon>
      <v-icon small @click="deleteItem(item)" title="Supprimer">mdi-delete</v-icon>
    </template>
    <template v-slot:no-data>
      <v-btn color="primary" @click="initialize">Reset</v-btn>
    </template>
  </v-data-table>
</template>

<script>
import axios from "axios";

export default {
  name: "HomePage",

  data: () => ({
    items: ["TPE", "PME", "ETI", "Grand groupe", "Association"],
    newsurveys: [],
    picker: new Date().toISOString().substr(0, 10),

    dialog: false,
    headers: [
      {
        text: "Titre du questionnaire",
        align: "start",
        sortable: false,
        value: "name"
      },
      { text: "Nom du client", value: "client" },
      { text: "Type d'entreprise", value: "type" },
      { text: "Créé le", value: "created" },

      { text: "Actions", value: "actions", sortable: false }
    ],
    surveys: [],
    editedIndex: -1,
    editedItem: {
      name: "",
      client: "",
      type: "",
      created: ""
    },
    defaultItem: {
      name: "",
      client: "",
      type: "",
      created: ""
    }
  }),

  beforeMount() {
    axios
      .get(`http://localhost:3005/surveys`)
      .then(response => {
        this.newsurveys = response.data;
      })
      .catch(e => {
        this.errors.push(e);
      });
  },
  watch: {
    dialog(val) {
      val || this.close();
    }
  },

  created() {
    this.initialize();
  },

  methods: {
    initialize() {
      this.surveys = [
        {
          name: "Exemple questionnaire",
          client: "Big client",
          created: "12 / 03 / 2020",
          type: "PME"
        }
      ];
    },

    editItem(item) {
      this.editedIndex = this.surveys.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    deleteItem(item) {
      const index = this.surveys.indexOf(item);
      confirm("Are you sure you want to delete this item?") &&
        this.surveys.splice(index, 1);
    },

    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
    },

    save() {
      if (this.editedIndex > -1) {
        Object.assign(this.surveys[this.editedIndex], this.editedItem);
      } else {
        this.surveys.push(this.editedItem);
      }
      this.close();
    }
  }
};
</script>

<style scoped>
.v-icon.v-icon.v-icon--link {
  margin: 4px;
  color: gray;
}

.router-link {
  text-decoration: none;
  margin-right: 5px;
  color: gray;
}
</style>
