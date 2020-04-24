<template>
  <div>
    <p>Nom du questionnaire : {{currentSurveys.survey_title}}</p>
    <p>Type d'entreprise : {{currentSurveys.company.company_type}}</p>
    <p>answer Id : {{picked}}</p>

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
                      <input
                        type="checkbox"
                        :value="currentSurvey.answer_quote"
                        @input="isPicked"
                        @change="postAnswer()"
                      />
                      <label>{{ currentSurvey.answerId }}</label>
                      <label>quote : {{currentSurvey.answer_quote}}</label>
                      <label>{{ currentSurvey.answer_title }}</label>
                    </div>
                  </div>
                </v-expansion-panel-content>
              </div>
            </v-expansion-panel>
          </v-expansion-panels>
        </v-row>
      </div>
      <button class="survey_submit_button" @click="updateAnswer">Soumettre</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "MySurvey",

  data: () => ({
    editedIndex: -1,
    popout: true,
    tile: true,
    isClicked: true,
    currentSurveys: [],
    picked: "",
    currentTopic: 0
  }),

  mounted() {
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
      let topicId = this.currentTopic;
      axios
        .post(`http://localhost:3005/submit`, {
          answer_quote: this.picked,
          // topicId: this.topic,

          topic_title: this.currentSurveys.company.models[0].topics[topicId]
            .topic_title,
          surveyId: this.currentSurveys.id
        })
        .then(function(data) {
          console.log(data);
        });
    },
    //get only one id when chekcbox is cliked
    isPicked: function($event) {
      this.picked = parseInt($event.target.value);
    },

    isTopic: function($event) {
      this.topic = parseInt($event.target.value);
    },

    //test put
    updateAnswer() {
      if (this.editedIndex > -1) {
        axios
          .put(`http://localhost:3005/submit/` + this.$route.params.id, {
            answerId: this.picked
          })
          .then(function(data) {
            console.log(data);
          });
      } else {
        {
          console.log(this.editedIndex);
          axios.post(`http://localhost:3005/submit`, {
            surveyId: 1
          });
        }
      }
    },
    editItem(item) {
      this.editedIndex = this.currentSurveys.indexOf(item);
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
