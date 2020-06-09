<template>
  <div class="register-container">
    <v-card max-width="344" class="register">
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title class="headline">Créer un compte</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-card-text>
        <v-form ref="form" class="form">
          <!-- FIRSTNAME -->
          <v-text-field
            ref="firstname"
            v-model="firstname"
            :error-messages="errorMessages"
            label="Prénom"
            required
          ></v-text-field>

          <!-- LASTNAME -->
          <v-text-field
            ref="lastname"
            v-model="lastname"
            :error-messages="errorMessages"
            label="Nom"
            required
          ></v-text-field>
          <!-- COMPANY NAME -->
          <v-text-field
            ref="cieName"
            v-model="cieName"
            :error-messages="errorMessages"
            label="Nom de l'entreprise"
            required
          ></v-text-field>
          <!-- PHONE NUMBER -->
          <v-text-field
            ref="phoneNumber"
            v-model="phoneNumber"
            :error-messages="errorMessages"
            label="N° de téléphone"
            maxlength="10"
            counter
            required
          ></v-text-field>
          <!--EMAIL-->
          <v-text-field
            ref="email"
            v-model="email"
            :error-messages="errorMessages"
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

          <v-dialog v-model="dialog" width="500">
            <template v-slot:activator="{ on }">
              <v-btn
                color="#175a77"
                class="mr-4 white--text"
                :disabled="disabled"
                @click="(checkPasswords(password, password_confirmation),handleSubmit(), showModal, DeleteInfosAfterRegister)"
                v-on="on"
              >Enregistrer</v-btn>
            </template>

            <v-card v-if="samePassword==true">
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

            <!-- *** -->

            <v-card v-if="samePassword==false">
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
    email: "",
    cieName: "",
    phoneNumber: "",
    password: "",
    password_confirmation: "",
    checkbox: false,
    date: "",

    disabled: true,
    samePassword: null,
    errorMessages: "",
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

  //check if something is written in the form fields
  watch: {
    name() {
      this.errorMessages = "";
    }
  },

  mounted() {
    this.getPresentDate();
  },

  methods: {
    //check if password respect good practicies/
    password_check: function() {
      this.has_number = /\d/.test(this.password);
      this.has_uppercase = /[A-Z]/.test(this.password);
      this.has_special = /[!@#$%^&*+=._-]/.test(this.password);
    },

    //enable register button if CGU checkbox is cliked
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
            CGU: !this.disabled,
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
      if (password.length !== password_confirmation) {
        this.samePassword = false;
      }
      let newPassword = password
        .split("")
        .sort()
        .join("");
      let newPasswordConfirmation = password_confirmation
        .split("")
        .sort()
        .join("");
      if (newPassword === newPasswordConfirmation) {
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

      console.log("currentDate", this.date);
    }
  }

  //post
};
</script>

<style lang="scss" scoped>
.register-container {
  display: flex;
  justify-content: center;
  height: 100%;

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
</style>