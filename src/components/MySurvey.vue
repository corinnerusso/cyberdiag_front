<template>
  <div>
    <div v-for="(item, index) in items" v-bind:key="index">
      <p>{{item.model_title}}</p>

      <v-row align="center">
        <v-expansion-panels
          :accordion="accordion"
          :popout="popout"
          :inset="inset"
          :multiple="multiple"
          :focusable="focusable"
          :disabled="disabled"
          :readonly="readonly"
          :flat="flat"
          :hover="hover"
          :tile="tile"
        >
          <v-expansion-panel v-for="(item, index) in item.topics" v-bind:key="index">
            <v-expansion-panel-header style="color:white">
              {{
              item.topic_title
              }}
            </v-expansion-panel-header>
            <v-expansion-panel-content v-for="(item, index) in item.questions" v-bind:key="index">
              <div class="survey_questions">
                <p>{{item.questionId}} - {{ item.question_title }}</p>
                <p>{{item.comments}}</p>
                <div v-for="(item, index) in item.answers" :key="index">
                  <!-- <p v-for="(item, index) in item.answers" :key="index"> -->
                  <input type="checkbox" id="checkbox" v-model="checked" />
                  <label for="one">{{item.answer_title}}</label>
                  <!-- </p> -->
                </div>
              </div>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
      </v-row>

      <button class="survey_submit_button">Soumettre</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "MySurvey",

  data() {
    return {
      accordion: false,
      popout: true,
      inset: false,
      multiple: false,
      disabled: false,
      readonly: false,
      focusable: false,
      flat: false,
      hover: false,
      tile: true,
      isClicked: true,
      items: []
    };
  },

  beforeMount() {
    axios
      .get(`http://localhost:3005/models`)
      .then(response => {
        // JSON responses are automatically parsed.
        this.items = response.data;
      })
      .catch(e => {
        this.errors.push(e);
      });
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
