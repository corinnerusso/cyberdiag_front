<template>
  <div style="margin-top:100px" class="contact">
    Page de contact
    <form @submit.prevent="handleSubmit">
      <div class="form-group form-check" v-for="item in Items" v-bind:key="item.id">
        <label class="form-check-label">{{item.name}}</label>
        <input type="checkbox" v-model="user.fruitCollection" :value="item.name" />
      </div>

      <!-- print result -->
      <div class="form-group">{{user.fruitCollection}}</div>

      <div class="form-group">
        <button class="btn btn-primary">Submit</button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  name: "Contact",
  data() {
    return {
      Items: [
        {
          name: "Apple"
        },
        {
          name: "Orange"
        },
        {
          name: "Mengo"
        },
        {
          name: "Cherry"
        }
      ],
      user: {
        fruitCollection: []
      }
    };
  },
  methods: {
    handleSubmit() {
      alert(JSON.stringify(this.user));
    }
  }
};
</script>