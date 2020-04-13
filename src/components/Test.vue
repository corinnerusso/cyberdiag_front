<template>
  <div>
    <ul>
      <li v-for="(info, x) in infos" :key="x">
        <h3>{{ info.message }}</h3>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "Test",
  //   props: ["info"],
  props: {
    infos: {
      type: Array,
    },
  },
};
</script>

<style scoped></style>
