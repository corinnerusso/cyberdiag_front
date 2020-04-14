<template>
  <div>
    <p>Nom du questionnaire : {{currentSurveys.survey_title}}</p>
    <p>Type d'entreprise : {{currentSurveys.company.company_type}}</p>

    <div>
      <div v-for="(currentSurvey, index) in currentSurveys" v-bind:key="index">
        <v-row align="center">
          <v-expansion-panels :popout="popout" :tile="tile">
            <v-expansion-panel
              v-for="(currentSurvey, index) in currentSurvey.models"
              v-bind:key="index"
            >
              <div v-for="(currentSurvey, index) in currentSurvey.topics" v-bind:key="index">
                <v-expansion-panel-header style="color:white">{{ currentSurvey.topic_title }}</v-expansion-panel-header>

                <v-expansion-panel-content
                  v-for="(currentSurvey, index) in currentSurvey.questions"
                  v-bind:key="index"
                >
                  <div class="survey_questions">
                    <p>{{ currentSurvey.questionId }} - {{ currentSurvey.question_title }}</p>
                    <p>{{ currentSurvey.comments }}</p>
                    <div v-for="(currentSurvey, index) in currentSurvey.answers" :key="index">
                      <input type="radio" value="answerId" />
                      <label for="one">{{ currentSurvey.answerId }}</label>
                      <label for="one">{{ currentSurvey.answer_title }}</label>
                    </div>
                  </div>
                </v-expansion-panel-content>
              </div>
            </v-expansion-panel>
          </v-expansion-panels>
        </v-row>
      </div>
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

    currentSurveys: []
  }),

  beforeMount() {
    axios
      .get(`http://localhost:3005/surveys/` + this.$route.params.id)
      .then(response => {
        this.currentSurveys = response.data;
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
