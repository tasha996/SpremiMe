<template>
  <v-app>
    <!-- All pages -->
    <router-view/>

    <!-- Main SnackBar -->
    <v-snackbar
      v-model="snackbar"
      :bottom="'bottom'"
      :timeout="timeout"
      :vertical="false"
    >
      {{ text }}
      <v-btn
        color="#eaaa09"
        flat
        @click="snackbar = false"
      >
        Close
      </v-btn>
    </v-snackbar>
    <!-- End SnackBar -->
  </v-app>
</template>

<script>
export default {
  name: 'App',
  data () {
    return {
      snackbar: false,
      timeout: 2000,
      text: 'Hello, I\'m a snackbar'
    }
  },
  methods: {
    showSnack: function (msg) {
      this.text = msg;
      this.snackbar = true;
    }
  },
  mounted() {
    // snackbar listener
    this.$root.$on('showMsg', (msg) => {
      this.showSnack(msg);
    });
  }
}
</script>



<style>

body, html {
  margin: 0;
  padding: 0;
  font-family: 'Cabin', sans-serif;
  background-color: #fff;
}

html {
  overflow-y: auto !important;
}

/* Fixes */

.account .v-tabs__div {
  font-weight: 800;
}

.search label {
  /* font-size: 18px !important; */
  /* letter-spacing: 0.05em; */
  color: #11111199 !important;
}

aside {
  overflow: visible !important;
}

.search input {
  color: #111 !important;
}

/* Scroll */
::-webkit-scrollbar{width: 0px;}
::-webkit-scrollbar-thumb{background-color:#ebebeb;}
::-webkit-scrollbar-thumb:hover{background-color:#ff1744;}
::-webkit-scrollbar-track{background-color:rgb(39, 39, 39);}
</style>
