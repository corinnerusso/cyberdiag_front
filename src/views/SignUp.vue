<template>
  <div class="register-container">
    <v-card max-width="344" class="register">
      <v-list-item>
        <v-list-item-title class="headline1">Créer un compte</v-list-item-title>
      </v-list-item>

      <v-card-text>
        <v-form ref="form" class="form">
          <!-- FIRSTNAME -->
          <v-text-field
            ref="firstname"
            v-model="firstname"
            :rules="generalRules"
            label="Prénom"
            required
          ></v-text-field>

          <!-- LASTNAME -->
          <v-text-field
            ref="lastname"
            v-model="lastname"
            :rules="generalRules"
            label="Nom"
            required
          ></v-text-field>

          <!-- COMPANY NAME -->
          <v-text-field
            ref="cieName"
            v-model="cieName"
            :rules="generalRules"
            label="Nom de l'entreprise"
            required
          ></v-text-field>

          <!-- PHONE NUMBER -->
          <v-text-field
            ref="phoneNumber"
            v-model="phoneNumber"
            label="N° de téléphone"
            maxlength="10"
            counter
            required
          ></v-text-field>

          <!--EMAIL-->
          <v-text-field
            ref="email"
            v-model="email"
            :rules="emailRules"
            label="Email"
            required
          ></v-text-field>

          <!-- PASSWORD -->
          <v-text-field
            label="Mot de passe"
            name="password"
            minlength="12"
            counter
            :type="show1 ? 'text' : 'password'"
            @input="password_check"
            v-model="password"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show1"
          ></v-text-field>
          <div class="frmValidation">
            <p :class="{'frmValidation--passed' : password.length > 11}">
              <v-icon v-if="password.length > 11">done</v-icon>Doit contenir au moins 12 caractères
            </p>
            <p :class="{'frmValidation--passed' :has_uppercase }">
              <v-icon v-if="has_uppercase">done</v-icon>Une lettre en majuscule
            </p>

            <p :class="{'frmValidation--passed' : has_number }">
              <v-icon v-if="has_number">done</v-icon>Un chiffre
            </p>
            <p :class="{'frmValidation--passed' : has_special }">
              <v-icon v-if="has_special">done</v-icon>Un caractère special
            </p>
          </div>

          <!-- PASSWORD CONFIRMATION -->
          <v-text-field
            label="Confirmer le mot de passe"
            v-model="password_confirmation"
            :type="show1 ? 'text' : 'password'"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show1"
          ></v-text-field>

          <v-checkbox v-model="checkbox" @change="(enableButton())">
            <template v-slot:label>
              <div>
                J'ai lu
                <v-tooltip bottom>
                  <template v-slot:activator="{ on }">
                    <a
                      target="_blank"
                      href="http://localhost:8080/legal-terms"
                      @click.stop
                      v-on="on"
                    >les mentions légales</a>
                  </template>
                  Ouvre dans un nouvel onglet
                </v-tooltip>
              </div>
            </template>
          </v-checkbox>

          <!-- MODAL -->

          <v-dialog v-model="dialog" width="300">
            <template v-slot:activator="{ on }">
              <v-btn
                color="#001f68"
                class="mr-4 white--text"
                :disabled="disabled"
                @click="(checkPasswords(password, password_confirmation),handleSubmit(), showModal, DeleteInfosAfterRegister)"
                v-on="on"
              >Enregistrer</v-btn>
            </template>

            <v-card class="modal" v-if="samePassword==true">
              <v-card-title class="headline grey lighten-2" primary-title>Confirmation</v-card-title>

              <v-card-text>Un e-mail de confirmation va vous être envoyé à l'adresse {{this.email}}</v-card-text>

              <v-divider></v-divider>

              <v-card-actions>
                <v-spacer></v-spacer>
                <router-link to="/">
                  <v-btn color="primary" text @click="dialog = false">Fermer</v-btn>
                </router-link>
              </v-card-actions>
            </v-card>

            <!-- MODAL IF THE 2 PASSWORDS ARE DIFFERENT -->

            <v-card class="modal" v-if="samePassword==false">
              <v-card-title class="headline grey lighten-2" primary-title>ERREUR</v-card-title>

              <v-card-text>Les mots de passe ne correspondent pas</v-card-text>

              <v-divider></v-divider>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" text @click="dialog = false">Fermer</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-form>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "SignUp",
  data: () => ({
    firstname: "",
    lastname: "",
    cieName: "",
    generalRules: [
        v => !!v || 'Ce champ est requis'
    ],
    email: "",
    emailRules: [
        v => !!v || 'E-mail is required',
        v => /.+@.+\..+/.test(v) || 'Ce champ doit avoir un format valide',
      ],
    
    phoneNumber: "",
    password: "",
    password_confirmation: "",
    checkbox: false,
    date: "",

    disabled: true,
    samePassword: null,
    errors: [],

    has_number: false,
    has_uppercase: false,
    has_special: false,

    show1: false,

    modal: false,
    dialog: false
  }),

  //check form
  computed: {
    form() {
      return {
        firstname: this.firstname,
        lastname: this.lastname,
        cieName: this.cieName,
        phoneNumber: this.phoneNumber,
        email: this.email
      };
    }
  },

 

  //set the date to insert in database
  mounted() {
    this.getPresentDate();
  },

  methods: {
    //check if password respect good practicies
    password_check: function() {
      this.has_number = /\d/.test(this.password);
      this.has_uppercase = /[A-Z]/.test(this.password);
      this.has_special = /[!@#$%^&*+=._-]/.test(this.password);
    },

    //enable register button if legal terms checkbox is cliked
    enableButton() {
      this.disabled = !this.disabled;
    },

    //submit form
    handleSubmit() {
      if (
        this.password === this.password_confirmation &&
        this.password.length > 0 &&
        this.password_confirmation.length > 0
      ) {
        axios
          .post(`http://localhost:3005/register`, {
            firstname: this.firstname,
            lastname: this.lastname,
            email: this.email,
            cie_name: this.cieName,
            phone_number: this.phoneNumber,
            password: this.password_confirmation,
            legal_terms: !this.disabled,
            user_creation_date: this.date
          })
          .then(response => {
            console.log(response.data);
          })
          .catch(e => {
            this.errors.push(e);
            console.log(this.errors);
          });
      }
    },

    //modal
    showModal() {
      if ((this.disabled = false)) {
        this.modal = true;
      }
    },

    //check if the 2 passwords are the same
    checkPasswords(password, password_confirmation) {
      if (password.length !== password_confirmation.length) {
        this.samePassword = false;
      }
     
      if (password === password_confirmation) {
        this.samePassword = true;
      } else {
        this.samePassword = false;
      }
      console.log("samePassword", this.samePassword);
    },

    //Empty datas when form is sent
    DeleteInfosAfterRegister() {
      (this.firstname = ""),
        (this.lastname = ""),
        (this.cieName = ""),
        (this.email = ""),
        (this.password = ""),
        (this.password_confirmation = "");
    },

    getPresentDate() {
      var currentDate = new Date();

      this.date = new Date()
        .toJSON()
        .slice(0, 10)
        .replace(/-/g, "/");
    }
  }
};
</script>

<style lang="scss" scoped>
.register-container {
  display: flex;
  justify-content: center;
  height: 100%;
  padding-top: 10px;

  .register {
    align-self: center;
    min-width: 50%;
    margin-bottom: 4%;
  }
}
.form {
  padding: 3%;
}

.frmLabel {
  display: block;
  margin-bottom: 10px;
  font-weight: bold;
}
.frmValidation {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  line-height: 0.5rem;
  padding-left: 3%;
  padding-bottom: 3%;
}
.frmValidation--passed {
  color: green;
}

@media screen and (max-width: 640px) {
  .register-container {
    padding-bottom: 20%;
  }
  .headline1 {
    font-size: 1.5rem;
  }

  .register {
    width: 85%;
  }

  .form {
    margin: 0;
    padding: 0;
  }

  .frmValidation {
    font-size: 0.8rem;
  }

  
}
</style>