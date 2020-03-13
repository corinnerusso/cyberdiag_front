<template>
  <div style="margin-top:100px" class="login">
    <LoginPage />
  </div>
</template>

<script>
// @ is an alias to /src
import LoginPage from "@/components/LoginPage.vue";

export default {
  name: "Login",
  components: {
    LoginPage
  }
};
</script>

<style scoped>
.login {
  padding-left: 10%;
  padding-right: 10%;
}
</style>
