<template>
  <div style="margin-top:100px" class="account">
    <MyAccount v-bind:userDatas="userDatas" :isUserId="isUserId" />
  </div>
</template>

<script>
// @ is an alias to /src
import MyAccount from "@/components/MyAccount.vue";
import axios from "axios";

export default {
  name: "My_account",
  components: {
    MyAccount
  },

  data() {
    return {
      userDatas: [],
      isUserId: null
    };
  },

  created() {
    this.setUserId();
  },

  beforeMount() {
    this.retrieveUserDatas();
  },

  methods: {
    //set user id
    setUserId() {
      this.storageUser = JSON.parse(localStorage.getItem("user"));
      this.isUserId = this.storageUser.user.id;
    },

    //get user datas
    retrieveUserDatas() {
      axios
        .get(`http://localhost:3005/users/` + this.isUserId)
        .then(response => {
          this.userDatas.push(response.data);
          console.log(response.data);
        })
        .catch(e => {
          console.log(e);
        });
    },

    //change user datas
    changeDatas() {
      axios.put(`http://localhost:3005/users/` + this.isUserId);
    }
  }
};
</script>