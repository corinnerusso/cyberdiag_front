<template>
  <div style="margin-top:100px" class="login">
    <div class="box">
      <h2>Login</h2>
      <form>
        <p class="error" v-if="error===400">Mot de passe ou email erroné</p>
        <div class="inputBox">
          <v-text-field v-model="email" type="email" label="email" required></v-text-field>
        </div>
        <div class="inputBox">
          <v-text-field
            v-model="password"
            label="password"
            :type="show1 ? 'text' : 'password'"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show1"
            @keyup.enter="handleSubmit"
            required
          ></v-text-field>
        </div>

        <v-btn color="#175a77" class="vbtn" @click="handleSubmit">Login</v-btn>
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
import axios from "axios";
export default {
  name: "SignIn",

  data() {
    return {
      email: "",
      password: "",
      users: [],
      error: "",
      show1: false
    };
  },

  mounted() {
    this.getAll();
  },

  methods: {
    getAll() {
      axios.get("http://localhost:3005/users").then(response => {
        this.users = response.data;
      });
    },

    handleSubmit(e) {
      e.preventDefault();
      if (this.password.length > 0) {
        axios
          .post("http://localhost:3005/login", {
            email: this.email,
            password: this.password
          })
          .then(
            response => {
              console.log("response.data", response.data);

              let is_admin = response.data.user.user.is_admin;

              localStorage.setItem("user", JSON.stringify(response.data.user));
              localStorage.setItem("jwt", response.data.token);
              if (localStorage.getItem("jwt") == null) {
                this.showError !== this.showError;
              }
              if (localStorage.getItem("jwt") != null) {
                this.$emit("loggedIn");

                if (this.$route.params.nextUrl != null) {
                  this.$router.push(this.$route.params.nextUrl);
                } else {
                  if (is_admin !== 1) {
                    this.$router.push("home");
                  } else {
                    this.$router.push("dashboard");
                  }
                }
              }
            },
            error => {
              this.error = error.response.status;
            }
          )
          .catch(function(error) {
            console.error("error", error.response);
          });
      }
    }
  }
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
.vbtn {
  color: white;
}
.error {
  color: red;
  background-color: transparent !important;
}

.user {
  padding-top: 5%;
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
