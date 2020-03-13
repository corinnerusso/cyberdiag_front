<template>
  <div>
    <div class="account_detail">Détail du compte</div>
    <div class="account_input">
      <p>email</p>
      <p>email@email.com</p>
      <button>Modifier</button>
    </div>

    <div class="account_input">
      <p>Mot de passe</p>
      <p>*******</p>
      <button>Modifier</button>
    </div>
  </div>
</template>

<script>
export default {
  name: "MyAccount"
};
</script>

<style scoped>
.account_detail {
  background-color: #4ca3bb;
  text-align: start;
  margin: 0 10% 0 10%;
  padding: 1.2vw;
  color: white;
  font-weight: bold;
}

.account_input {
  display: flex;
  background-color: white;
  text-align: start;
  margin: 0 10% 0 10%;
  padding: 1.2vw;
  color: black;
  justify-content: space-between;
  border: 0.1rem solid grey;
}

button {
  background-image: linear-gradient(to right, #56b1c8, #175a77);
  padding-left: 1vw;
  padding-right: 1vw;
  border-radius: 5px;
}
</style>
