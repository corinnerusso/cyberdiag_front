import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home
  },
  {
    path: "/about",
    name: "About",
    component: () => import("../views/About.vue")
  },
  {
    path: "/contact",
    name: "Contact_page",
    component: () => import("../views/Contact.vue")
  },
  {
    path: "/general-terms",
    name: "General_terms",
    component: () => import("../views/GeneralTerms.vue")
  },
  {
    path: "/account",
    name: "My_account",
    component: () => import("../views/Account.vue")
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;
