import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import Chapter from '../views/Chapter.vue';
import Article from '../views/Article.vue';

const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/chapter/:id', name: 'Chapter', component: Chapter },
  { path: '/article/:id', name: 'Article', component: Article },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
