<template>
  <div style="margin-top:100px" class="home">
    <MyAccount />
  </div>
</template>

<script>
// @ is an alias to /src
import MyAccount from "@/components/MyAccount.vue";

export default {
  name: "My_account",
  components: {
    MyAccount
  }
};
</script>