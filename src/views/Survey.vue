<template>
  <div style="margin-top:100px;color:black;" class="survey">
    <MySurvey />
  </div>
</template>

<script>
import MySurvey from "@/components/MySurvey.vue";

export default {
  name: "Survey",

  components: {
    MySurvey
  }
};
</script>

<style scoped>
.survey {
  padding-left: 10%;
  padding-right: 10%;
}
</style>
