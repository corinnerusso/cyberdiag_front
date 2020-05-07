<template>
  <div>
    <p>Nom du questionnaire : {{ currentSurveys.survey_title }}</p>

    <p>Type d'entreprise : {{ currentSurveys.company.company_type }}</p>
    <p>All question Ids : {{allQuestionsIds}}</p>
    <p>checkedQuestions : {{checkedQuestions}}</p>
    <p>Not answered questions : {{notAnsweredQuestions}}</p>

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
                  <div style="text-align : start">
                    <p style="font-weight:bold">
                      {{ surveyQuestion.questionId }} -
                      {{ surveyQuestion.question_title }}
                    </p>
                    <p style="font-style:italic">{{ surveyQuestion.comments }}</p>
                    <!-- 5th loop to access answers -->

                    <div v-for="(surveyAnswer, index) in surveyQuestion.answers" :key="index">
                      <input
                        type="radio"
                        :value="surveyAnswer.answerId"
                        v-model="surveyQuestion.answer"
                        @change="getCheckedIds(currentSurveys.id,surveyModel.modelId,surveyTopic.topicId, surveyQuestion.questionId, surveyAnswer.answerId)"
                      />
                      <label>{{ surveyAnswer.answer_title }}</label>
                    </div>
                  </div>
                </v-expansion-panel-content>
              </v-expansion-panel>
            </v-expansion-panel>
          </v-expansion-panels>
        </v-row>
      </div>
      <br />

      <!-- modal -->
      <!-- <div class="text-center">
        <v-dialog v-model="modal" width="500">
          <template v-slot:activator="{ on }">
            <v-btn
              color="blue-grey darken-4"
              dark
              v-on="on"
              @click="(questionIsChecked(),showIds(),compareArrays(allQuestionsIds, checkedQuestions), showModal()),finalSubmit()"
            >Soumettre</v-btn>
          </template>
          <div v-if="modal">
            <v-card>
              <v-card-title class="headline grey lighten-2" primary-title>Réponses manquantes</v-card-title>

              <v-card-text>Merci de répondre aux questions suivantes : {{notAnsweredQuestions}}.</v-card-text>

              <v-divider></v-divider>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" text @click="(closeModal(), viderTableau())">Fermer</v-btn>
              </v-card-actions>
            </v-card>
          </div>
        </v-dialog>
      </div>-->

      <!-- modal -->
      <div>
        <button
          class="survey_submit_button"
          @click="(questionIsChecked(),showIds(),compareArrays(allQuestionsIds, checkedQuestions), showModal()),surveyIsAnswered(),finalSubmit()"
        >Soumettre</button>
        <transition name="fade">
          <div v-if="modal">
            <div>
              <h2 class="mb-2">Réponses manquantes</h2>
              <p>Merci de répondre aux questions suivantes : {{notAnsweredQuestions}}</p>
              <button @click="(closeModal(),viderTableau())">Close</button>
            </div>
          </div>
        </transition>
      </div>
      <!-- modal  -->

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
    finalArray: [],
    allQuestionsIds: [],
    checkedQuestions: [],
    notAnsweredQuestions: [],
    modal: false
  }),

  created() {
    axios
      .get(`http://localhost:3005/surveys/` + this.$route.params.id)
      .then(response => {
        this.currentSurveys = response.data;
      })
      .catch(e => {
        console.log(e);
      });
  },

  beforeMount() {},

  methods: {
    viderTableau: function() {
      if (this.notAnsweredQuestions.length >= 1) {
        this.notAnsweredQuestions = [];
        this.checkedQuestions = [];
        this.allQuestionsIds = [];
      }
    },
    //********** RADIO BUTTON FUNCTIONS ****************//

    //function to modelize all the checked ids as an array of ids object (finalArray)
    getCheckedIds: function(id, modelId, topicId, questionId, answerId) {
      var finalAnswer = { id, modelId, topicId, questionId, answerId };
      this.finalArray[questionId] = finalAnswer;
    },

    //********** SUBMIT BUTTON FUNCTIONS ****************//
    // create an array with all the question ids checked (checkedQuestions[])
    questionIsChecked: function() {
      this.finalArray.forEach(
        x => (
          (this.isSurveyId = x.id),
          (this.isModelId = x.modelId),
          (this.isTopicId = x.topicId),
          (this.isQuestionId = x.questionId),
          (this.isAnswerId = x.answerId),
          this.checkedQuestions.push(this.isQuestionId)
        )
      );
    },

    //create an array with all the ids of the current survey (allQuestionsIds[])
    showIds() {
      this.currentSurveys.company.models.forEach(item => {
        item.topics.forEach(topic => {
          topic.questions.forEach(question =>
            this.allQuestionsIds.push(question.questionId)
          );
        });
      });
    },

    //compare two arrays, checkedQuestions[] and allQuestionsIds[] and create an array
    //array with all questions not checked (notAnsweredQuestions[])
    compareArrays(allQuestionsIds, checkedQuestions) {
      const array1 = allQuestionsIds
        .toString()
        .split(",")
        .map(Number);
      const array2 = checkedQuestions
        .toString()
        .split(",")
        .map(Number);

      for (var i in array1) {
        if (!array2.includes(array1[i]))
          this.notAnsweredQuestions.push(array1[i]);
      }
      for (i in array2) {
        if (!array1.includes(array2[i]))
          this.notAnsweredQuestions.push(array2[i]);
      }
    },

    //iterate over all the objects of finalArray and post ids in each loop (axios request)
    finalSubmit: function() {
      if (this.notAnsweredQuestions.length === 0) {
        this.finalArray.forEach(
          x => (
            (this.isSurveyId = x.id),
            (this.isModelId = x.modelId),
            (this.isTopicId = x.topicId),
            (this.isQuestionId = x.questionId),
            (this.isAnswerId = x.answerId),
            axios.post(`http://localhost:3005/submit`, {
              surveyId: this.isSurveyId,
              answerId: this.isAnswerId,
              modelId: this.isModelId,
              topicId: this.isTopicId,
              questionId: this.isQuestionId
            })
            // .then(function(data) {
            //   console.log(data);
            // })
          )
        );
      }
    },

    //********** MODAL FUNCTIONS ****************//
    //show modal
    showModal() {
      if (this.notAnsweredQuestions.length < 1) {
        this.modal = false;
      } else {
        this.modal = true;
      }
      console.log(this.notAnsweredQuestions.length);
      console.log(this.modal);
    },

    // close modal
    closeModal() {
      if (this.modal == false) {
        this.modal = true;
      } else {
        this.modal = false;
      }
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

p {
  margin-bottom: 7px;
  margin-top: 7px;
}

input,
label {
  margin-left: 10px;
}
input:invalid {
  border: 2px dashed red;
}

input:valid {
  border: 1px solid black;
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

/* MODAL BUTTON */
.bg-smoke {
  background-color: rgba(0, 0, 0, 0.2);
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
