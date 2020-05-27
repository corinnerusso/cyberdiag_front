<template>
  <div class="register-container">
    <v-card max-width="344" class="register">
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title class="headline">Créer un compte</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-card-text>
        <v-form ref="form" v-model="valid" class="form">
          <v-text-field v-model="firstname" :rules="firstnameRules" label="Prénom" required></v-text-field>
          <v-text-field v-model="lastname" :rules="lastnameRules" label="Nom" required></v-text-field>
          <v-text-field v-model="cieName" :rules="cieName" label="Nom de l'entreprise" required></v-text-field>
          <v-text-field v-model="phoneNumber" :rules="phoneNumber" label="N° de téléphone" required></v-text-field>
          <v-text-field v-model="email" :rules="emailRules" label="Email" required></v-text-field>

          <v-text-field
            v-model="password"
            :rules="passwordRules"
            type="password"
            label="Mot de passe"
            required
          ></v-text-field>

          <v-text-field
            v-model="password_confirmation"
            :rules="passwordRules"
            type="password"
            label="Confirmer le mot de passe"
            required
          ></v-text-field>

          <v-btn color="#175a77" class="mr-4" @click="handleSubmit">Register</v-btn>
        </v-form>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
export default {
  name: "SignUp"
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
</style>