import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";


Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Login",
    component: () => import("@/views/Login.vue"),
  },
  {
    path: "/register",
    name: "SignUp",
    component: () => import("@/views/SignUp.vue"),
  },
  {
    path: "/home",
    name: "Home",
    component: Home,
  },
  {
    path: "/about",
    name: "About",
    component: () => import("@/views/About.vue"),
  },
  {
    path: "/contact",
    name: "Contact",
    component: () => import("@/views/Contact.vue"),
  },
  {
    path: "/legal-terms",
    name: "LegalTerms",
    component: () => import("@/views/LegalTerms.vue"),
  },
  {
    path: "/account",
    name: "My_account",
    component: () => import("@/views/Account.vue"),
  },

  {
    path: "/survey/:id",
    name: "Survey",
    component: () => import("@/views/Survey.vue"),
  },


  {
    path: "/charts/:id",
    name: "Charts",
    component: () => import("@/views/Charts.vue"),
  },
  {
    path: "/dashboard",
    name: "Dashboard",
    component: () => import("@/views/Dashboard.vue"),
  },

];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
