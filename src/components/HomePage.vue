<template>
  <div>
    <div class="hompepage_title">
      <h1>MES QUESTIONNAIRES</h1>
    </div>

    <!-- <div>
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
    <div>
      <ul class="homepage_table">
        <li>Titre du questionnaire</li>
        <li>Nom du client</li>
        <li>Type entreprise</li>
        <li>Créé le</li>
        <li>Actions</li>
      </ul>-->
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

  margin: 0 10% 0 10%;
  border-radius: 5px;
}

.homepage_table {
  display: flex;
  justify-content: space-between;
  list-style: none;
  background-color: red;
  margin: 5% 10% 5% 10%;
  text-align: center;
}

/* TABLE */
/* thead {
  background-color: brown;
  margin-left: auto !important;
  margin-right: auto !important;
} */
</style>
