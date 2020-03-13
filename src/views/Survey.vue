<template>
  <div style="margin-top:100px;color:black;" class="survey">
    <MySurvey />
  </div>
</template>

<script>
// @ is an alias to /src
import MySurvey from "@/components/MySurvey.vue";

export default {
  name: "Survey",

  components: {
    MySurvey
  }
};
</script>
