import Vue from "vue";
import Vuetify from "vuetify/lib";

import { VTextField } from "vuetify/lib";
import { Ripple } from 'vuetify/lib/directives'
Vue.use(Vuetify, {
    components: {
        VTextField
    },
    directives: {
        Ripple,
      },
});

export default new Vuetify({});
