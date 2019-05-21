<template>
  <div class="recepti">
    <div class="layoutGrid">
      <tile v-for="(r,i) in all" :key="'t' + r" :id="Number(r)" :index="(i % 9) + 1"></tile>
    </div>
    <!-- Button -->
    <v-btn to="/dodaj" fab color="#eaaa09" fixed bottom right>
      <v-icon>restaurant</v-icon>
    </v-btn>
  </div>
</template>

<script>
import Tile from "@/components/Tile.vue";
import ajax from '../http-common.js';

export default {
  components: {
    Tile
  },
  data() {
    return {
      all: [],
      sastojci: [],
      empty: false
    };
  },
  methods: {
    loadRecepte(ids) {
      // pripremi string
      let sIds = '';
      for (let i = 0; i < ids.length; i++) {
        const id = ids[i];
        sIds += 'sastojci[' + i + ']=' + id + '&';
      }

      ajax.get('search?' + sIds)
      .then(res => {
        console.log(res.data);
        // upisi u tiles
        this.all = res.data;
      })
      .catch(e => {
          console.log(e);
      });
    }
  },
  mounted() {
    // listen for changes
    this.$root.$on("newSearch", ids => {
      this.loadRecepte(ids);
    });
    // initiate data
    this.loadRecepte([]);
  }
};
</script>

<style scoped>
.layoutGrid {
  display: flex;
  flex-wrap: wrap;
}
</style>
