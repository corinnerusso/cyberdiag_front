<template>
  <div style="margin-top:100px" class="login">
    <div class="box">
      <h2>Login</h2>
      <form>
        <div class="inputBox">
          <input
            type="email"
            name="email"
            required
            onkeyup="this.setAttribute('value', this.value);"
            value
          />
          <label>Identifiant</label>
        </div>
        <div class="inputBox">
          <input
            type="password"
            name="password"
            required
            value
            onkeyup="this.setAttribute('value', this.value);"
            pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
            title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
          />
          <label>Mot de passe</label>
        </div>
        <input type="submit" name="sign-in" value="Sign In" />
      </form>
      <div class="signup">
        <p class="user">Nouvel utilisateur ?</p>
        <router-link :to="`/register`">
          <button class="button">Créer un compte</button>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "SignIn"
};
</script>

<style scoped>
.signup {
  display: flex;
  justify-content: space-between;
  padding-top: 1.2rem;
  color: white;
}
.button {
  background-color: #175a77;
  border-radius: 0.312rem;
  padding: 0.625rem 1.25rem;
  cursor: pointer;
  color: white;
}

.user {
  padding-top: 5%;
}
.login {
  padding-left: 10%;
  padding-right: 10%;
}
.box {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 25rem;
  padding: 2.5rem;
  box-sizing: border-box;
  background: #bdbdbd;
  border-radius: 0.625rem;
}

.box h2 {
  margin: 0 0 1.875rem;
  padding: 0;
  color: #fff;
  text-align: center;
}

.box .inputBox {
  position: relative;
}

.box .inputBox input {
  width: 100%;
  padding: 0.625rem 0;
  font-size: 1rem;
  color: #fff;
  letter-spacing: 0.062rem;
  margin-bottom: 1.875rem;
  border: none;
  border-bottom: 0.065rem solid #fff;
  outline: none;
  background: transparent;
}

.box .inputBox label {
  position: absolute;
  top: 0;
  left: 0;
  padding: 0.625rem 0;
  font-size: 1rem;
  color: #fff;
  pointer-events: none;
  transition: 0.5s;
}

.box .inputBox input:focus ~ label,
.box .inputBox input:valid ~ label,
.box .inputBox input:not([value=""]) ~ label {
  top: -1.125rem;
  left: 0;
  color: #175a77;
  font-size: 0.75rem;
}

.box input[type="submit"] {
  border: none;
  outline: none;
  color: #fff;
  background-color: #175a77;
  padding: 0.625rem 8.25rem;
  cursor: pointer;
  border-radius: 0.312rem;
  font-size: 1rem;
}

.box input[type="submit"]:hover {
  background-color: #175a77;
}
</style>
