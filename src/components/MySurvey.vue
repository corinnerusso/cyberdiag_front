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
              v-for="(currentSurvey, index) in currentSurvey.models"
              v-bind:key="index"
            >
              <!-- 3ème boucle pour atteindre les données de "topic" (les sujets du questionnaire) -->
              <div v-for="(currentSurvey, index) in currentSurvey.topics" v-bind:key="index">
                <v-expansion-panel-header style="color:white">{{ currentSurvey.topic_title }}</v-expansion-panel-header>

                <!-- 4ème boucle pour atteindre les données des questions' -->
                <v-expansion-panel-content
                  v-for="(currentSurvey, index) in currentSurvey.questions"
                  v-bind:key="index"
                >
                  <div class="survey_questions">
                    <p>
                      {{ currentSurvey.questionId }} -
                      {{ currentSurvey.question_title }}
                    </p>
                    <p>{{ currentSurvey.comments }}</p>
                    <!-- 5ème boucle pour afficher sous forme de checkbox les réponses possibles. Un seul choix possible -->
                    <!-- Dans un premier temps, je veux utiliser la fonction "postAnswer" pour poster les informations suivantes dans une table spécifique à chaque click de checkbox : 
                    surveyId, 
                    modelId, 
                    topicId, 
                    questionId 
                    et answerId-->
                    <!-- Je récupère la donnée answerId par la fonction "isPicked" -->
                    <div v-for="(currentSurvey, index) in currentSurvey.answers" :key="index">
                      <input
                        type="checkbox"
                        :value="currentSurvey.answerId"
                        @input="isPicked"
                        @change="postAnswer()"
                      />
                      <label>{{ currentSurvey.answerId }}</label>
                      <!-- <label>quote : {{ currentSurvey.answer_quote }}</label> -->
                      <label>{{ currentSurvey.answer_title }}</label>
                    </div>
                  </div>
                </v-expansion-panel-content>
              </div>
            </v-expansion-panel>
          </v-expansion-panels>
        </v-row>
      </div>
      <button class="survey_submit_button">Soumettre</button>
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
    picked: ""
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
    postAnswer() {
      axios
        .post(`http://localhost:3005/submit`, {
          answerId: this.picked, //récupère la valeur de l'answerId
          surveyId: this.currentSurveys.id //récupère la valeur de surveyId
          // modelId:??
          // topicId:??
          // questionId:??

          // topicId: this.currentSurveys.company.models[0].topics[1].topicId
          // peut fonctionner si on arrive à changer dynamiquement les valeurs des index
        })
        .then(function(data) {
          console.log(data);
        });
    },
    //récupère la valeur de l'id de la checkbox
    isPicked: function($event) {
      this.picked = parseInt($event.target.value);
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
