<template>
  <div>
    <ul v-for="(info,index) in infos" v-bind:key="index"></ul>
    <li>{{info.message}}</li>
  </div>
</template>

<script>
export default {
  name: "Test",
  props: ["info"]
};
</script>

<style scoped>
</style>
