import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/Home.vue";
import CreateNewRoom from "../views/CreateNewRoom.vue";
import Room from "../views/Room.vue";

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/create",
    name: "Create",
    component: CreateNewRoom,
  },
  {
    path: "/rooms/:uuid",
    name: "Room",
    component: Room,
  }

]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

export default router;
