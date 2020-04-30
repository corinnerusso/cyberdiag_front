<template>
  <div>
    <p>Nom du questionnaire : {{ currentSurveys.survey_title }}</p>
    <p>Type d'entreprise : {{ currentSurveys.company.company_type }}</p>

    <div>
      <!-- 1ère boucle pour parser les données -->
      <div v-for="(currentSurvey, index) in currentSurveys" v-bind:key="index">
        <v-row align="center">
          <v-expansion-panels :popout="popout" :tile="tile">
            <!-- 2ème boucle pour atteindre les données de modèle de questionnaire (s'il s'agit d'un modèle pour TPE, PME, etc) -->
            <v-expansion-panel
              v-for="(surveyModel, index) in currentSurvey.models"
              v-bind:key="index"
            >
              <!-- 3ème boucle pour atteindre les données de "topic" (les sujets du questionnaire) -->
              <v-expansion-panel
                v-for="(surveyTopic, index) in surveyModel.topics"
                v-bind:key="index"
              >
                <v-expansion-panel-header style="color:white">{{ surveyTopic.topic_title }}</v-expansion-panel-header>

                <!-- 4ème boucle pour atteindre les données des questions' -->
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
                    <!-- 5ème boucle pour afficher sous forme de checkbox les réponses possibles. Un seul choix possible -->
                    <!-- Dans un premier temps, je veux utiliser la fonction "postAnswer" pour poster les informations suivantes dans une table spécifique à chaque click de checkbox : 
                    surveyId, 
                    modelId, 
                    topicId, 
                    questionId 
                    et answerId-->
                    <!-- Je récupère la donnée answerId par la fonction "isPicked" -->
                    <div v-for="(surveyAnswer, index) in surveyQuestion.answers" :key="index">
                      <input
                        type="checkbox"
                        @change="postAnswer(currentSurveys.id,surveyModel.modelId, surveyTopic.topicId, surveyQuestion.questionId, surveyAnswer.answerId)"
                      />
                      <label>{{ surveyAnswer.answerId }}</label>
                      <!-- <label>quote : {{ currentSurvey.answer_quote }}</label> -->
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
        <button class="survey_submit_button">Soumettre</button>
      </div>
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
    currentSurveys: []
  }),

  // Il est possible de voir un schéma de la BDD dans les assets
  //récupérer les données de la BDD et les stocker dans la data "currentSurvey:[]"
  mounted() {
    axios
      .get(`http://localhost:3005/surveys/` + this.$route.params.id) //voir le fichier surveydata.json
      .then(response => {
        this.currentSurveys = response.data;
      })
      .catch(e => {
        console.log(e);
      });
  },

  //poster les infos des checkbox cochées//
  methods: {
    postAnswerTest: function(surveyId, modelId, topicId, questionId, answerId) {
      console.log(surveyId, modelId, topicId, questionId, answerId);
    },

    postAnswer: function(surveyId, modelId, topicId, questionId, answerId) {
      axios
        .post(`http://localhost:3005/submit`, {
          answerId: answerId,
          surveyId: surveyId,
          modelId: modelId,
          topicId: topicId,
          questionId: questionId

          // topicId: this.currentSurveys.company.models[0].topics[1].topicId
          // peut fonctionner si on arrive à changer dynamiquement les valeurs des index
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
  position: flex 2;
}
</style>
