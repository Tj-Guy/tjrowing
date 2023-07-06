// Composables
import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('@/components/HelloWorld.vue'),
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/components/logIn.vue'),
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

export default router