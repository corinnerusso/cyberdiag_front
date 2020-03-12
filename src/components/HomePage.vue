<template>
  <v-data-table :headers="headers" :items="surveys" sort-by="client" class="elevation-1">
    <template v-slot:top>
      <p>BARRE DE RECHERCHE</p>
      <v-toolbar color="#4CA3BB">
        <v-toolbar-title color="white !important">MES QUESTIONNAIRES</v-toolbar-title>
        <v-divider class="mx-4" inset vertical></v-divider>
        <v-spacer></v-spacer>
        <v-dialog v-model="dialog" max-width="500px">
          <template v-slot:activator="{ on }">
            <v-btn color="#40778f" dark class="mb-2" v-on="on">Nouveau questionnaire</v-btn>
          </template>

          <v-card>
            <v-card-title>
              <span class="headline">{{ formTitle }}</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.name" label="Survey"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.client" label="client"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.created" label="created"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.type" label="type"></v-text-field>
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
      <v-icon
        small
        class="mr-2"
        @click="editItem(item)"
        title="Modifier le questionnaire"
      >mdi-pencil</v-icon>
      <v-icon small @click="deleteItem(item)" title="Supprimer">mdi-delete</v-icon>
      <v-icon small @click="deleteItem(item)" title="Aller au questionnaire">arrow_right_alt</v-icon>
      <v-icon small @click="deleteItem(item)" title="Voir les résultats">trending_up</v-icon>
    </template>
    <template v-slot:no-data>
      <v-btn color="primary" @click="initialize">Reset</v-btn>
    </template>
  </v-data-table>
</template>

<script>
export default {
  name: "HomePage",

  data: () => ({
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
}
</style>
