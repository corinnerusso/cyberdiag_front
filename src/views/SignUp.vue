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
            :rules="[rules.required]"
            :error-messages="errorMessages"
            label="Prénom"
            placeholder="Jean"
            required
          ></v-text-field>

          <!-- LASTNAME -->
          <v-text-field
            ref="lastname"
            v-model="lastname"
            :rules="[rules.required]"
            :error-messages="errorMessages"
            label="Nom"
            placeholder="Dupont"
            required
          ></v-text-field>
          <!-- COMPANY NAME -->
          <v-text-field
            ref="cieName"
            v-model="cieName"
            :rules="[() => !!cieName || 'Champs obligatoire']"
            :error-messages="errorMessages"
            label="Nom de l'entreprise"
            placeholder="..."
            required
          ></v-text-field>
          <!-- PHONE NUMBER -->
          <v-text-field
            ref="phoneNumber"
            v-model="phoneNumber"
            :rules="[rules.required]"
            :error-messages="errorMessages"
            label="N° de téléphone"
            placeholder="0600000000"
            maxlength="10"
            counter
            required
          ></v-text-field>
          <!--EMAIL-->
          <v-text-field
            ref="email"
            v-model="email"
            :rules="[rules.required, rules.email]"
            :error-messages="errorMessages"
            label="Email"
            placeholder="jean.martin@mail.com"
            required
          ></v-text-field>

          <!-- PASSWORD -->
          <v-text-field
            label="Mot de passe"
            placeholder="Mot de passe"
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
            placeholder="Mot de passe"
            :type="show1 ? 'text' : 'password'"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show1"
            :once="checkPasswords(password, password_confirmation)"
            :rules="[rules.password]"
            hide-details="auto"
          ></v-text-field>

          <v-btn color="#175a77" class="mr-4 white--text" @click="handleSubmit">Register</v-btn>
        </v-form>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import axios from "axios";
import { sameAs } from "vuelidate/lib/validators";
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
    color: "green",
    notcolor: "red",

    samePassword: null,
    errorMessages: "",
    errors: [],
    formHasErrors: false,

    has_number: false,
    has_uppercase: false,
    has_special: false,

    show1: false,

    rules: {
      required: value => !!value || "Champs obligatoire",
      email: value => {
        const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return pattern.test(value) || "Invalid e-mail.";
      },
      password: value => (!!value && value !== this.password) || "not ok"
    }
  }),

  //vuelidate

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
      this.checkPassword();
    }
  },

  methods: {
    //*********** */
    password_check: function() {
      this.has_number = /\d/.test(this.password);
      this.has_uppercase = /[A-Z]/.test(this.password);
      this.has_special = /[!@#$%^&*+=._-]/.test(this.password);
    },

    //submit form
    handleSubmit() {
      if (
        this.password === this.password_confirmation &&
        this.password.length > 0
      ) {
        axios
          .post(`http://localhost:3005/users`, {
            firstname: this.firstname,
            lastname: this.lastname,
            email: this.email,
            cieName: this.cieName,
            phoneNumber: this.phoneNumber,
            password: this.password
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
    //check if all the fields are completed
    submit() {
      this.formHasErrors = false;

      Object.keys(this.form).forEach(f => {
        if (!this.form[f]) this.formHasErrors = true;

        this.$refs[f].validate(true);
      });
    },

    //check if the 2 passwords are the same

    checkPasswords(password, password_confirmation) {
      //   console.log("password", password, "passconf", password_confirmation);
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
      console.log("samepassword", this.samePassword);
    }
  }
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