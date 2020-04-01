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
                    <v-text-field v-model="editedItem.survey_title" label="Questionnaire"></v-text-field>
                  </v-col>

                  <!-- "Nom du client" input dans la modal -->
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.client_name" label="Client"></v-text-field>
                  </v-col>
                  <!-- "Créé le" input dans la modal -->
                  <v-col cols="12" sm="6" md="4">
                    <span>Crée le</span>
                    <br />
                    <input type="date" v-model="editedItem.creation_date" label="Créé le" />
                  </v-col>
                  <!-- "Type d'entreprise" input dans la modal -->
                  <v-col cols="12" sm="6" md="4">
                    <v-overflow-btn
                      v-model="editedItem.company"
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
  </v-data-table>
</template>

<script>
import axios from "axios";

export default {
  name: "HomePage",

  data: () => ({
    // items: ["TPE", "PME", "ETI", "Grand groupe", "Association"],
    items: ["1", "2", "3", "4", "5"],
    surveys: [],
    picker: new Date().toISOString().substr(0, 10),

    dialog: false,
    headers: [
      {
        text: "Titre du questionnaire",
        align: "start",
        sortable: false,
        value: "survey_title"
      },
      { text: "Nom du client", value: "client_name" },
      { text: "Type d'entreprise", value: "company.company_type" },
      { text: "Créé le", value: "creation_date" },

      { text: "Actions", value: "actions", sortable: false }
    ],

    editedIndex: -1,
    editedItem: {
      survey_title: "",
      client_name: "",
      company: "",
      creation_date: ""
    },
    defaultItem: {
      survey_title: "",
      client_name: "",
      company: "",
      creation_date: ""
    }
  }),

  beforeMount() {
    axios
      .get(`http://localhost:3005/surveys`)
      .then(response => {
        this.surveys = response.data;
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

  methods: {
    editItem(item) {
      this.editedIndex = this.surveys.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    deleteItem(item) {
      const index = this.surveys.indexOf(item);
      confirm("Suppression de ce questionnaire ?") &&
        this.surveys.splice(index, 1);
      axios
        .delete(`http://localhost:3005/surveys/` + item.id)
        .then(response => {
          console.log(response);
        });
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
        axios
          .put(`http://localhost:3005/surveys/` + this.editedItem.id, {
            survey_title: this.editedItem.survey_title,
            client_name: this.editedItem.client_name,
            creation_date: this.editedItem.creation_date,
            company: this.editedItem.company
          })
          .then(response => {
            console.log(response);
          });

        Object.assign(this.surveys[this.editedIndex], this.editedItem);
        this.close();
      } else {
        {
          console.log("created data");
          console.log(this.editedItem);
          axios
            .post(`http://localhost:3005/surveys`, {
              survey_title: this.editedItem.survey_title,
              client_name: this.editedItem.client_name,
              creation_date: this.editedItem.creation_date,
              company: this.editedItem.company
            })
            .then(response => {
              console.log(response);
            });
          this.surveys.push(this.editedItem);
        }
        this.close();
      }
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
