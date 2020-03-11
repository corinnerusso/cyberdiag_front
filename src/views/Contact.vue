<template>
  <div style="margin-top:100px" class="home">
    <ContactPage />
  </div>
</template>

<script>
// @ is an alias to /src
import ContactPage from "@/components/ContactPage.vue";

export default {
  name: "Contact-page",
  components: {
    ContactPage
  }
};
</script>