<template>
  <div>
    <div class="hompepage_title">
      <h1>MES QUESTIONNAIRES</h1>
    </div>

    <div>
      <table>
        <thead>
          <th>Titre du questionnaire</th>
          <th>Nom du client</th>
          <th>Type entreprise</th>
          <th>Créé le</th>
          <th>Actions</th>
        </thead>
      </table>
    </div>

    <div>test</div>
  </div>
</template>

<script>
export default {
  name: "HomePage"
};
</script>

<style scoped>
.hompepage_title {
  color: white;
  background-color: #226782;
  /* width: 80%; */

  /* margin: 0 10% 0 10%; */
  border-radius: 5px;
}

table {
  background-color: red;
}
</style>
