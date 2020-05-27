<template>
  <div style="margin-top:100px" class="login">
    <SignIn />
  </div>
</template>

<script>
import SignIn from "@/components/SignIn.vue";
// @ is an alias to /src

export default {
  name: "Login",
  components: {
    SignIn
  }
};
</script>

<style scoped>
</style>
