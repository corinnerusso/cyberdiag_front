<template>
  <div>
    <p>Nom du questionnaire : {{ currentSurveys.survey_title }}</p>

    <p>Type d'entreprise : {{ currentSurveys.company.company_type }}</p>

    <div>
      <!-- 1rst loop to parse all datas -->
      <div v-for="(currentSurvey, index) in currentSurveys" v-bind:key="index">
        <v-row align="center">
          <v-expansion-panels :popout="popout" :tile="tile">
            <!-- 2nd loop to access models -->
            <v-expansion-panel
              v-for="(surveyModel, index) in currentSurvey.models"
              v-bind:key="index"
            >
              <!-- 3rd loop to access topics -->
              <v-expansion-panel
                v-for="(surveyTopic, index) in surveyModel.topics"
                v-bind:key="index"
              >
                <v-expansion-panel-header style="color:white">{{ surveyTopic.topic_title }}</v-expansion-panel-header>

                <!-- 4th loop to access questions -->
                <v-expansion-panel-content
                  v-for="(surveyQuestion, index) in surveyTopic.questions"
                  v-bind:key="index"
                >
                  <div class="survey_questions">
                    <p>
                      {{ surveyQuestion.questionId }} -
                      {{ surveyQuestion.question_title }}
                    </p>
                    <p>{{ surveyQuestion.comments }}</p>
                    <!-- 5th loop to access answers -->

                    <div v-for="(surveyAnswer, index) in surveyQuestion.answers" :key="index">
                      <input
                        type="radio"
                        :value="surveyAnswer.answerId"
                        v-model="surveyQuestion.answer"
                        @change="getCheckedIds(currentSurveys.id,surveyModel.modelId,surveyTopic.topicId, surveyQuestion.questionId, surveyAnswer.answerId)"
                      />
                      <label>{{ surveyAnswer.answerId }}</label>

                      <label>{{ surveyAnswer.answer_title }}</label>
                    </div>
                  </div>
                </v-expansion-panel-content>
              </v-expansion-panel>
            </v-expansion-panel>
          </v-expansion-panels>
        </v-row>
      </div>
      <div>
        <button class="survey_submit_button" @click="finalSubmit()">Soumettre</button>
      </div>
      <br />
      <br />
      <br />
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
    currentSurveys: [],
    isSurveyId: null,
    isModelId: null,
    isTopicId: null,
    isQuestionId: null,
    isAnswerId: null,
    finalArray: []
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

  methods: {
    //function to modelize all the checked ids as an array of ids object
    getCheckedIds: function(id, modelId, topicId, questionId, answerId) {
      var finalAnswer = { id, modelId, topicId, questionId, answerId };
      this.finalArray[questionId] = finalAnswer;
      // console.log(this.finalArray);
      // console.log("finalArray : ", this.finalArray);
    },

    //function which iterates over all the objects of finalArray and post ids in each loop
    finalSubmit: function() {
      this.finalArray.forEach(
        x => (
          (this.isSurveyId = x.id),
          (this.isModelId = x.modelId),
          (this.isTopicId = x.topicId),
          (this.isQuestionId = x.questionId),
          (this.isAnswerId = x.answerId),
          axios
            .post(`http://localhost:3005/submit`, {
              surveyId: this.isSurveyId,
              answerId: this.isAnswerId,
              modelId: this.isModelId,
              topicId: this.isTopicId,
              questionId: this.isQuestionId
            })
            .then(function(data) {
              console.log(data);
            })
        )
      );
      // console.log(
      //   "survey",
      //   this.isSurveyId,
      //   "model",
      //   this.isModelId,
      //   "topic",
      //   this.isTopicId,
      //   "question",
      //   this.isQuestionId,
      //   "answer",
      //   this.isAnswerId
      // );
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
  position: flex 2;
}
</style>
