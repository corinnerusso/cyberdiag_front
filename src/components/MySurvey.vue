<template>
  <div>
    <p>Nom du questionnaire : {{currentSurvey.survey_title}}</p>
    <div v-for="(item, index) in items" v-bind:key="index">
      <v-row align="center">
        <v-expansion-panels :popout="popout" :tile="tile">
          <v-expansion-panel v-for="(item, index) in item.topics" v-bind:key="index">
            <v-expansion-panel-header style="color:white">{{ item.topic_title }}</v-expansion-panel-header>
            <v-expansion-panel-content v-for="(item, index) in item.questions" v-bind:key="index">
              <div class="survey_questions">
                <p>{{ item.questionId }} - {{ item.question_title }}</p>
                <p>{{ item.comments }}</p>
                <div v-for="(item, index) in item.answers" :key="index">
                  <input type="radio" v-model="item.checked" value="answerId" />
                  <label for="one">{{ item.answerId }}</label>
                  <label for="one">{{ item.answer_title }}</label>
                </div>
              </div>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
      </v-row>

      <button class="survey_submit_button" @click="postAnswer">Soumettre</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "MySurvey",

  data: () => ({
    popout: true,
    tile: true,
    isClicked: true,
    items: [],
    currentSurvey: null
  }),

  //get topics + comments + questions from database//
  beforeMount() {
    axios
      .get(`http://localhost:3005/models`)
      .then(response => {
        this.items = response.data;
      })
      .catch(e => {
        this.errors.push(e);
      });

    axios
      .get(`http://localhost:3005/surveys/` + this.$route.params.id)
      .then(response => {
        this.currentSurvey = response.data;
        console.log(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  },

  //post checked boxes into submission table//
  methods: {
    postAnswer() {
      axios
        .post(`http://localhost:3005/submit`, {
          answerId: this.answerId
        })
        .then(function(data) {
          console.log(data);
        });
    }
  }
};
</script>

<style scoped>
/* THEME TITLE */
.v-application--is-ltr .v-expansion-panel-header {
  background-image: linear-gradient(to right, #56b1c8, #175a77);
}

/*QUESTIONS*/

.survey_questions {
  text-align: start;
}
p {
  margin-bottom: 7px;
  margin-top: 7px;
}

input,
label {
  margin-left: 10px;
}

/* SUBMIT BUTTON */

.survey_submit_button {
  background-image: linear-gradient(to right, #56b1c8, #175a77);
  margin-top: 2vw;
  padding: 1vw;
  border-radius: 5px;
  color: white;
}
</style>
