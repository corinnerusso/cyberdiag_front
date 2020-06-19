<template>
  <div class="infos">
    <div>
      <div class="survey_title">
        <img
          :src="require('../assets/survey.png')"
          height="50"
          width="70"
          contain
          style="padding-right:20px"
        />
        <h2>Titre : {{userSurvey.survey_title}}</h2>
      </div>

      <!-- 1rst loop to access models -->
      <div v-for="(currentSurvey, index) in userSurvey.company.models" v-bind:key="index">
        <v-row align="center">
          <v-expansion-panels :popout="popout" :tile="tile">
            <!-- 3rd loop to access topics -->
            <v-expansion-panel
              v-for="(surveyTopic, index) in currentSurvey.topics"
              v-bind:key="index"
            >
              <v-expansion-panel-header style="color:#162967">
                {{ surveyTopic.topic_title }}
                <div class="topic_questions">
                  <p style="padding-left:10px">Questions n°</p>
                  <p
                    style="padding-left:10px"
                    v-for="(surveyQuestion, index) in surveyTopic.questions"
                    v-bind:key="index"
                  >{{ surveyQuestion.questionNumber }}</p>
                </div>
              </v-expansion-panel-header>

              <!-- 4th loop to access questions -->
              <v-expansion-panel-content
                v-for="(surveyQuestion, index) in surveyTopic.questions"
                v-bind:key="index"
              >
                <div style="text-align : start" class="subparagraph">
                  <p style="font-weight:bold">
                    {{ surveyQuestion.questionNumber }} -
                    {{ surveyQuestion.question_title }}
                  </p>
                  <p style="font-style:italic">{{ surveyQuestion.comments }}</p>
                  <!-- 5th loop to access answers -->

                  <div v-for="(surveyAnswer, index) in surveyQuestion.answers" :key="index">
                    <input
                      type="radio"
                      :value="surveyAnswer.answerId"
                      v-model="surveyQuestion.answer"
                      @change="getCheckedIds(
                          userSurvey.id,
                         userSurvey.company.models[0].modelId,
                          surveyTopic.topicId, 
                          surveyQuestion.questionId, 
                          surveyQuestion.questionNumber,
                          surveyAnswer.answerId, 
                          surveyAnswer.answer_quote, 
                          userSurvey.survey_title, 
                          surveyTopic.topic_title, 
                          surveyTopic.topic_max_quote)"
                    />
                    <label>{{ surveyAnswer.answer_title }}</label>
                  </div>
                </div>
              </v-expansion-panel-content>
            </v-expansion-panel>
          </v-expansion-panels>
        </v-row>
      </div>
      <br />

      <div class="text-center">
        <v-dialog width="500">
          <template v-slot:activator="{ on }">
            <v-btn
              class="v-btn"
              color="#162967"
              dark
              v-on="on"
              @click="(questionIsChecked(),showIds(),compareArrays(allQuestionsNumbers, checkedQuestionsNumbers), showModal(),finalSubmit(),showChart(),closeModal(), userHasSurvey())"
            >Soumettre</v-btn>
          </template>
          <!-- modal -->
          <template v-if="modal">
            <div>
              <v-card>
                <v-card-title class="headline grey lighten-2" primary-title>Réponses manquantes</v-card-title>

                <v-card-text>Merci de répondre aux questions suivantes : {{notAnsweredQuestions}}.</v-card-text>

                <v-divider></v-divider>

                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn color="primary" text @click="(closeModal(), emptyArrays())">Fermer</v-btn>
                </v-card-actions>
              </v-card>
            </div>
          </template>
          <!-- ******************* -->
        </v-dialog>
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
    //vuetify component
    popout: true,
    tile: true,

    //functions

    allQuestionsNumbers: [],
    checkedQuestionsNumbers: [],
    finalArray: [],
    modal: true,
    notAnsweredQuestions: [],
    isSurveyId: null,
    isModelId: null,
    isTopicId: null,
    isQuestionId: null,
    isAnswerId: null,
    isAnswer_quote: null,
    isSurveyTitle: null,
    isTopicTitle: null,
    isTopicMaxQuote: null,
    isQuestionNumber: null,

    userSurvey: [],
    isUserId: null
  }),

  created() {
    axios
      .get(`http://localhost:3005/surveys/` + this.$route.params.id)
      .then(response => {
        this.userSurvey = response.data;
      })
      .catch(e => {
        console.log(e);
      }),
      this.setUserId();
  },

  methods: {
    //set userId
    setUserId: function() {
      this.storageUser = JSON.parse(localStorage.getItem("user"));
      this.isUserId = this.storageUser.user.id;
    },

    //********** RADIO BUTTON FUNCTIONS ****************//

    //function to modelize all the checked ids as an array of ids object (finalArray[])
    getCheckedIds: function(
      id,
      modelId,
      topicId,
      questionId,
      questionNumber,
      answerId,
      answer_quote,
      survey_title,
      topic_title,
      topic_max_quote
    ) {
      var finalAnswer = {
        id,
        modelId,
        topicId,
        questionId,
        questionNumber,
        answerId,
        answer_quote,
        survey_title,
        topic_title,
        topic_max_quote
      };
      this.finalArray[questionId] = finalAnswer;
      console.log(this.finalArray);
    },

    //********** SUBMIT BUTTON FUNCTIONS ****************//
    // create an array with all the question numbers checked (checkedQuestionsNumbers[])
    questionIsChecked: function() {
      this.finalArray.forEach(
        x => (
          (this.isSurveyId = x.id),
          (this.isModelId = x.modelId),
          (this.isTopicId = x.topicId),
          (this.isQuestionId = x.questionId),
          (this.isQuestionNumber = x.questionNumber),
          (this.isAnswerId = x.answerId),
          (this.isAnswer_quote = x.answer_quote),
          (this.isSurveyTitle = x.survey_title),
          (this.isTopicTitle = x.topic_title),
          (this.isTopicMaxQuote = x.topic_max_quote),
          this.checkedQuestionsNumbers.push(this.isQuestionNumber)
        )
      );
    },

    //create an array with all the questions numbers of the current survey (allQuestionsNumbers[])
    showIds() {
      this.userSurvey.company.models.forEach(item => {
        item.topics.forEach(topic => {
          topic.questions.forEach(question =>
            this.allQuestionsNumbers.push(question.questionNumber)
          );
        });
      });
    },

    //compare two arrays, checkedQuestionsNumbers[] and allQuestionsNumbers[] and create an array
    // with all questions not checked (notAnsweredQuestions[])
    compareArrays(allQuestionsNumbers, checkedQuestionsNumbers) {
      const array1 = allQuestionsNumbers
        .toString()
        .split(",")
        .map(Number);
      const array2 = checkedQuestionsNumbers
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
            (this.isAnswer_quote = x.answer_quote),
            (this.isSurveyTitle = x.survey_title),
            (this.isTopicTitle = x.topic_title),
            (this.isTopicMaxQuote = x.topic_max_quote),
            this.checkedQuestionsNumbers.push(this.isQuestionId),
            axios
              .post(`http://localhost:3005/submit`, {
                survey: this.isSurveyId,
                answerId: this.isAnswerId,
                modelId: this.isModelId,
                topicId: this.isTopicId,
                questionId: this.isQuestionId,
                answerQuote: this.isAnswer_quote,
                surveyTitle: this.isSurveyTitle,
                topicTitle: this.isTopicTitle,
                topicQuote: this.isTopicMaxQuote,
                userId: this.isUserId
              })
              .then(function(data) {
                console.log(data);
              })
          )
        );
      }
    },

    //set has_a_survey to true in survey table when a user submits a survey
    userHasSurvey: function() {
      if (this.notAnsweredQuestions.length === 0) {
        let surveyId = this.isSurveyId;
        axios
          .put(`http://localhost:3005/surveys/` + surveyId, {
            has_a_survey: true
          })
          .then(response => {
            console.log(response);
          });
      }
    },

    //********** MODAL FUNCTIONS ****************//
    //show modal
    showModal() {
      if (this.notAnsweredQuestions.length < 1) {
        this.modal = true;
      } else {
        this.modal = false;
      }
    },

    // close modal
    closeModal() {
      if (this.modal == true) {
        this.modal = false;
      } else {
        this.modal = true;
      }
    },

    //empty all arrays if all questions are not answered
    emptyArrays: function() {
      if (this.notAnsweredQuestions.length >= 1) {
        this.notAnsweredQuestions = [];
        this.checkedQuestionsNumbers = [];
        this.allQuestionsNumbers = [];
      }
    },

    //show charts when submit answers//
    showChart: function() {
      if (this.notAnsweredQuestions.length === 0) {
        this.$router.push("/charts/" + this.$route.params.id);
      }
    }
  }
};
</script>

<style scoped>
/* SURVEY TITLE */
.survey_title {
  margin: 1%;
  color: #162967;
  display: flex;
}

/* THEME TITLE */
.v-application--is-ltr .v-expansion-panel-header {
  font-size: 1.2em;
  border-radius: 5px;
}

/* TOPIC HEARDER */
.topic_questions {
  display: flex;
  font-size: 0.95rem;
}
/* PARAGRAPHS */
.subparagraph {
  background-color: #f5f8fa !important;
  border-radius: 5px;
  padding: 2%;
}

/*QUESTIONS*/

p {
  margin-bottom: 7px;
  margin-top: 7px;
}
.infos {
  font-size: 1.2em;
}
input,
label {
  margin-left: 10px;
}

.v-btn {
  font-size: 1.4em;
  margin: 2%;
  padding: 2% !important;
}
</style>
