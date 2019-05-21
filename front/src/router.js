import Vue from 'vue'
import Router from 'vue-router'

import Home from './views/Home.vue'
import Account from './views/Account.vue'
import Recepti from './views/Recepti.vue'
import Dodaj from './views/Dodaj.vue'
import Profil from './views/Profil.vue'
import Jelo from './views/Jelo.vue'
import ajax from './http-common.js';

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    { path: '/', component: Home,
      beforeEnter: (to, from, next) => {
        // check if user is logged in
        if (localStorage.getItem('token')) {
          // check if token is valid
          ajax.post('/validate')
          .then(res => {
              // check if response is ID
              next();
          })
          .catch(e => {
            // logout if error
            console.log(e);
            next('/login');
          });
        } else {
          next('/login');
        }
      },
      children: [
        { path: '/', redirect: '/recepti' },
        { path: '/recepti', component: Recepti },
        { path: '/dodaj', component: Dodaj },
        { path: '/profil/:idp', component: Profil },
        { path: '/recept/:idp', component: Jelo , props: true},
        { path: '/edit/:idp', component: Dodaj, props: { edit: true } },
      ],
    },
    { path: '/login', component: Account, props: { tab: 0 }},
    { path: '/signup', component: Account, props: { tab: 1 }}
  ]
})
