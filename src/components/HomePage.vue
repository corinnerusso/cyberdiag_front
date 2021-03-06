<template>
  <div class="container">
    <span class="search_field2">
      <v-card-title>
        <v-text-field v-model="search" append-icon="mdi-magnify" label="Chercher" hide-details></v-text-field>
      </v-card-title>
    </span>
    <v-data-table
      :headers="headers"
      :items="surveys"
      sort-by="client"
      :search="search"
      class="elevation-16"
    >
      <template v-slot:top>
        <v-toolbar color="#F5F8FA">
          <v-toolbar-title class="homepage_title">MES QUESTIONNAIRES</v-toolbar-title>
          <!-- search field -->
          <span class="search_field">
            <v-card-title>
              <v-text-field
                v-model="search"
                append-icon="mdi-magnify"
                label="Chercher"
                hide-details
              ></v-text-field>
            </v-card-title>
          </span>
          <v-spacer></v-spacer>
          <v-dialog v-model="dialog" max-width="500px">
            <!-- new survey button-->
            <template v-slot:activator="{ on }">
              <v-btn color="#142968" dark class="mb-2" v-on="on">Nouveau questionnaire</v-btn>
              <v-btn color="#142968" dark class="add_button" v-on="on">+</v-btn>
            </template>

            <v-card>
              <!-- MODAL -->
              <v-card-text>
                <v-container>
                  <v-row>
                    <!-- "survey title -->
                    <v-col cols="12" sm="6" md="4">
                      <v-text-field v-model="editedItem.survey_title" label="Questionnaire"></v-text-field>
                    </v-col>

                    <!-- client name -->
                    <v-col cols="12" sm="6" md="4">
                      <v-text-field v-model="editedItem.client_name" label="Client"></v-text-field>
                    </v-col>
                    <!-- creation date -->
                    <v-col cols="12" sm="6" md="4">
                      <span>Date</span>
                      <br />
                      <input type="date" v-model="editedItem.survey_creation_date" label="Créé le" />
                    </v-col>
                    <!-- company type -->
                    <v-col cols="12" sm="6" md="4">
                      <v-overflow-btn
                        v-model="editedItem.company"
                        v-bind:items="items"
                        label="Type d'entreprise"
                      ></v-overflow-btn>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>
              <!-- Close and save buttons in modal -->
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="close">Annuler</v-btn>
                <v-btn color="blue darken-1" text @click="save">Sauvegarder</v-btn>
              </v-card-actions>
              <!-- END OF MODAL -->
            </v-card>
          </v-dialog>
        </v-toolbar>
      </template>
      <!-- ACTIONS -->
      <template v-slot:item.actions="{ item }">
        <!-- Fill survey -->
        <span v-if="item.has_a_survey==false">
          <router-link class="router-link" :to="`/survey/${item.id}`">
            <v-icon
              class="router-link"
              title="Remplir le questionnaire"
              size="25"
              v-model="editedItem.id"
              @click="((showSurvey = editedItem.id))"
            >mdi-pencil</v-icon>
          </router-link>
        </span>
        <span v-else>
          <v-icon
            class="router-link"
            color="green"
            title="Questionnaire déjà complété"
            size="25"
            v-model="editedItem.id"
          >done</v-icon>
        </span>
        <!-- See graphs -->
        <router-link class="router-link" :to="`/charts/${item.id}`">
          <v-icon
            size="25"
            title="Voir les résultats"
            v-model="editedItem.id"
            @click="showSurvey = editedItem.id"
          >trending_up</v-icon>
        </router-link>

        <!-- Modify survey -->
        <v-icon
          size="20"
          class="mr-2"
          @click="editItem(item)"
          title="Modifier le questionnaire"
        >build</v-icon>

        <!-- Delete survey -->
        <v-icon size="20" @click="deleteItem(item)" title="Supprimer">mdi-delete</v-icon>
      </template>
    </v-data-table>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "HomePage",

  data: () => ({
    date: new Date().toISOString().substr(0, 10),
    search: "",
    showSurvey: null,
    currentSurvey: null,
    currentIndex: -1,
    items: [
      {
        text: "TPE",
        value: 1
      },
      {
        text: "PME",
        value: 2
      },
      {
        text: "ETI",
        value: 3
      },
      {
        text: "Grand Groupe",
        value: 4
      },
      {
        text: "Association",
        value: 5
      }
    ],

    surveys: [],
    picker: new Date().toISOString().substr(0, 10),

    dialog: false,
    headers: [
      {
        text: "Titre du questionnaire",
        align: "start",

        value: "survey_title"
      },
      { text: "Nom du client", value: "client_name" },
      { text: "Type d'entreprise", value: "company.company_type" },
      { text: "Créé le", value: "survey_creation_date" },

      { text: "Actions", value: "actions", sortable: false }
    ],

    editedIndex: -1,

    editedItem: {
      survey_title: "",
      client_name: "",
      company: "",
      survey_creation_date: "",
      isUserId: ""
    },

    storageUser: null
  }),

  created() {
    this.setUserId();
    this.userConnection();
  },
  beforeMount() {
    this.retrieveAllSurveys();
    this.userConnection();
  },

  updated() {
    this.retrieveAllSurveys();
  },
  watch: {
    dialog(val) {
      val || this.close();
    }
  },

  methods: {
    //set userId
    setUserId() {
      this.storageUser = JSON.parse(localStorage.getItem("user"));
      this.editedItem.isUserId = this.storageUser.user.id;
    },

    //set connected from false to true when a user is connected
    userConnection() {
      axios
        .put(`http://localhost:3005/users/` + this.editedItem.isUserId, {
          connected: true
        })
        .then(response => {
          console.log(response);
        });
    },

    editItem(item) {
      this.editedIndex = this.surveys.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },
    //retrieve all surveys for the user connected
    retrieveAllSurveys() {
      axios
        .get(`http://localhost:3005/surveys/user/` + this.editedItem.isUserId)
        .then(response => {
          this.surveys = response.data;
        })
        .catch(e => {
          console.log(e);
        });
    },

    //set the survey and survey index
    setActiveSurvey(survey, index) {
      this.currentSurvey = survey;
      this.currentIndex = index;
    },

    //delete a survey
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

    //close modal
    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedIndex = -1;
      }, 300);
    },

    //save a new survey or change an existed one
    save() {
      if (this.editedIndex > -1) {
        axios
          .put(`http://localhost:3005/surveys/` + this.editedItem.id, {
            survey_title: this.editedItem.survey_title,
            client_name: this.editedItem.client_name,
            survey_creation_date: this.editedItem.survey_creation_date,
            company: this.editedItem.company,
            user: this.editedItem.isUserId
          })
          .then(response => {
            console.log(response);
          });

        Object.assign(this.surveys[this.editedIndex], this.editedItem);
        this.close();
      } else {
        {
          axios
            .post(`http://localhost:3005/surveys`, {
              survey_title: this.editedItem.survey_title,
              client_name: this.editedItem.client_name,
              survey_creation_date: this.editedItem.survey_creation_date,
              company: this.editedItem.company,
              user: this.editedItem.isUserId
            })
            .then(response => {
              console.log("response", response);
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
.search_field {
  width: 40% !important;
  color: white !important;
  padding-left: 2% !important;
}

.search_field2 {
  display: none;
}
.v-icon.v-icon.v-icon--link {
  margin: 4px;
  color: gray;
}

.add_button {
  display: none;
}

.router-link {
  text-decoration: none !important;
  margin-right: 5px;
  color: gray;
}

@media screen and (max-width: 640px) {
  .container {
    padding-bottom: 25%;
  }
  .add_button {
    display: flex;
  }

  .mb-2 {
    display: none;
  }

  .homepage_title {
    display: none;
  }

  .search_field {
    display: none;
  }
  .search_field2 {
    display: flex;
  }
}
</style>
