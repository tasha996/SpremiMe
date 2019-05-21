<template>
  <v-container class="account" fluid fill-height align-center justify-center>
    <div class="acWrap">
      <div class="logo"></div>
      <v-card class="elevation-6 card">
        <v-tabs light grow fixed-tabs v-model="tabs" color="#eaaa0900" slider-color="#eaaa09" class="tabs" height="50">
          <v-tab :key="1">Login</v-tab>
          <v-tab :key="2">Sign Up</v-tab>
        </v-tabs>
        <v-tabs-items v-model="tabs" light class="wrapper" color="transparent">
          <v-tab-item :key="1">
            <login/>
          </v-tab-item>
          <v-tab-item :key="2">
            <signup/>
          </v-tab-item>
        </v-tabs-items>
      </v-card>
    </div>
  </v-container>
</template>

<script>
import Login from '@/components/Login.vue'
import Signup from '@/components/Signup.vue'
import ajax from '../http-common.js';

export default {
  name: 'account',
  props: ['tab'],
  data () {
      return {
        tabs: this.tab
      }
  },
  watch: {
    tabs: function (val) {
      if (val == "0")
        this.$router.push('login');
      else
        this.$router.push('signup');
    },
    tab: function (val) {
      this.tabs = val;
    }
  },
  methods: {
    // log user out
    logout() {
      if (localStorage.getItem('token')) {
        ajax.get('logout')
        .then(res => {
          // remove from storage
          localStorage.clear();
        })
        .catch(e => {
          // remove from storage
          localStorage.clear();
        });
      }
    }
  },
  created() {
    this.logout();
  },
  components: {
    Login,
    Signup
  }
}
</script>

<style scoped>
.account {
  background-color: #eee;
  padding: 0;
  font-family: 'Cabin', sans-serif;
  display: flex;
  flex-direction: column;
  background-image: url("../assets/images/back6.jpg");
  background-size: cover;
  background-position: center center;
  background-repeat: no-repeat;
  width: 100% !important;
}

.acWrap {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
  width: 100%;
  max-width: 500px;
  background-color: #eeeeee;
  padding: 20px;
}

.logo {
  background-image: url("../assets/images/Color.svg");
  background-size: contain;
  background-position: center center;
  background-repeat: no-repeat;
  height: 250px;
  width: 300px;
  margin-bottom: 50px;
  /* filter: invert(1); */
}

.card {
  width: 400px;
  max-width: 100%;
  background-color: transparent !important;
  box-shadow: none !important;
}

.tabs {
  font-weight: 700 !important;
}

.wrapper {
  padding: 35px 30px 20px;
  /* background-color: #333333; */
}

h1 {
  font-family: 'Cabin', sans-serif;
  font-weight: normal !important;
  text-align: center;
  margin-bottom: 30px;
  letter-spacing: 0.05em !important;
  font-size: 60px !important;
  opacity: 0.9;
}

@media only screen and (max-width: 500px) {
  .acWrap {
    padding: 10px;
    padding-top: 37px;
  }
}

</style>
