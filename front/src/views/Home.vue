<template>
  <v-container fluid class="home">
    <!-- Toolbar for mobile -->
    <v-toolbar color="#eaaa09" light app v-if="$vuetify.breakpoint.smAndDown" >
      <v-toolbar-side-icon @click="drawer = !drawer"></v-toolbar-side-icon>
      <v-toolbar-title class="tool">Spremi Me</v-toolbar-title>
      <v-spacer></v-spacer>
      <div class="authorImg">
        <v-img
          :src="require('@/assets/images/chef.svg')"
          position="center center"
          class="chef"
          contain
        ></v-img>
      </div>
      <v-btn icon>
        <v-icon>more_vert</v-icon>
      </v-btn>
    </v-toolbar>

    <!-- Side Navigation -->
    <v-navigation-drawer
      fixed
      v-model="drawer"
      app
      mobile-break-point="960"
      clipped
      floating
      class="drawer"
      width="350"
    >
      <div class="side elevation-8">
        <div class="logo"></div>

        <div class="flexWrapper">
          <div class="searchWrapper">
            <v-form ref="forms">
            <v-autocomplete class="search"
              :disabled="!showSearch"
              :items="items"
              :search-input.sync="search"
              item-text="naziv"
              item-value="info"
              v-model="select"
              full-width
              flat
              box
              hide-no-data
              hide-details
              label="Pretraga..."
              solo-inverted
              background-color="transparent"
              clearable
              color="#333333"
              append-icon="search"
            >
              <template slot="item" slot-scope="data">
                  <v-list-tile-avatar>
                    <v-icon color="orange">label</v-icon>
                  </v-list-tile-avatar>
                  <v-list-tile-content>
                    <v-list-tile-title v-html="data.item.naziv"></v-list-tile-title>
                  </v-list-tile-content>
                  <v-list-tile-action>
                    <v-list-tile-action-text v-html="'Nut: ' + data.item.nv"></v-list-tile-action-text>
                  </v-list-tile-action>
              </template>
            </v-autocomplete>
            </v-form>
          </div>
        </div>
        <div class="mainNav">
          <v-btn flat active-class="activeNav" class="btnNav" to="/recepti">Recepti</v-btn>
          <v-btn flat active-class="activeNav" class="btnNav" to="/dodaj">Dodaj</v-btn>
          <v-btn flat active-class="activeNav" class="btnNav" :to="`/profil/${id}`">Profil</v-btn>
          <v-btn flat active-class="activeNav" class="btnNav" to="/login">Odjava</v-btn>
        </div>
        <div class="links">
          <div class="link"></div>
          <div class="link"></div>
          <div class="link"></div>
          <div class="link"></div>
        </div>
      </div>
    </v-navigation-drawer>
  <!-- Main Content -->
  <v-content class="content">
    <router-view></router-view>
  </v-content>
  <!-- Sastojci -->
  <div class="sastojci">
    <v-chip v-for="(r, i) in sastojci" :key="'t' + i"
        dark 
        close 
        color="#111"
        class="elevation-3 chipMine"
        @input="skiniSastojak(r)"
    >
        {{r.name}}
    </v-chip>
  </div>
  </v-container>
</template>

<script>
import _ from 'lodash'
import ajax from '../http-common.js';

export default {
  data () {
    return {
      id : this.$root.user['id'],
      drawer : null,
      loading: false,
      items: [],
      search: null,
      select: null,
      sastojci: [],
      showSearch: true,
    }
  },
  watch: {
    search (val) {
      val && val !== this.select && this.searchSastojke(val, this)
    },
    select (val) {
      // dodaj u sastojke
      if (val!= null) {
        if (!this.sastojci.includes(val)) {
          this.sastojci.push(val);
          // console.log(this.sastojci);
          // obavesti recepte
          this.obavestiRecepte();
        }
        // resetuj formu
        this.$nextTick(() => {
          this.$refs.forms.reset();
        });
      }
    },
    $route (to, from){
        // provera stranice
        if (to.path != "/recepti") {
          this.sastojci = [];
          this.showSearch = false;
        } else {
          this.showSearch = true;
        }
    }
  },
  methods: {
    searchSastojke: _.debounce((v, that) => {
      that.loadSastojke(v);
    }, 500),
    // nadji sve sastojke sa podstringom
    loadSastojke(v) {
      ajax.get("/searchString?sub=" + v)
      .then(res => {
        this.items = [];
        // prikazi rezultate
        res.data.forEach(el => {
          this.items.push({
            naziv: el.naziv,
            nv: el.nv,
            info: { id: el.id, name: el.naziv }
          });
        });
      })
      .catch(e => {
        console.log(e);
      });
    },
    obavestiRecepte() {
      let ids = [];
      this.sastojci.forEach(el => {
       ids.push(el.id);
      });
      this.$root.$emit('newSearch', ids);
    },
    skiniSastojak(s) {
      console.log(s);
      // obrisi sastojak u nizu
      let index = this.sastojci.indexOf(s);
      if (index > -1) {
        this.sastojci.splice(index, 1);
      }
      // obavesti recepte o promeni
      this.obavestiRecepte();
    }
  },
  mounted() {
    // disable search
    if (this.$route.path != "/recepti") {
      this.showSearch = false;
    }
  }
}
</script>

<style scoped>

.home {
  padding: 0;
}

.tool {
  font-family: Oregano;
  font-size: 22px !important;
}
.miniLogo {
  width: 25px;
  height: 25px;
}
/* slika */
.chef {
  width: 50px;
  height: 50px;
  background-color: #bb3131;
  border: 2px solid #111;
  border-radius: 50%;
}

.drawer {
  background-color: #eaaa09 !important;
}

.side {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;
  position: relative;
  padding-bottom: 70px;
  z-index: 5;
}

.logo {
  background-image: url("../assets/images/Color.svg");
  background-size: contain;
  background-position: center bottom;
  background-repeat: no-repeat;
  height: 250px;
  width: 260px;
  margin-top: 30px;
  flex: 2;
  min-height: 180px;
}

.mainNav {
  margin-top: 10px;
  flex: 3;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.btnNav {
  width: 180px;
  height: 40px;
  /* border-bottom: 1px solid #33333322; */
  margin-bottom: 15px;
  font-family: 'Cabin', sans-serif;
  /* text-transform: none; */
  font-size: 15px;
  letter-spacing: 0.1em;
  font-weight: 900;

}

.activeNav {
  border-bottom: 2px solid #11111188;
}

.links {
  width: 200px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
  position: absolute;
  bottom: 0;
  opacity: 1;
}

.links .link {
  background-image: url("../assets/images/l1.svg");
  background-size: contain;
  background-position: center center;
  background-repeat: no-repeat;
  width: 25px;
  height: 25px;
}

.links .link:nth-child(1) {
  background-image: url("../assets/images/l1.svg");
}
.links .link:nth-child(2) {
  background-image: url("../assets/images/l2.svg");
}
.links .link:nth-child(3) {
  background-image: url("../assets/images/l3.svg");
}
.links .link:nth-child(4) {
  background-image: url("../assets/images/l4.svg");
}

.flexWrapper {
  flex: 2;
  display: flex;
  justify-content: center;
  align-items: center;
}

.searchWrapper {
  border: 2px solid #111;
  border-radius: 30px;
  width: 300px;
  padding: 0 20px;
}

.search {
  color: #111 !important;
  font-family: 'Cabin', sans-serif;
  font-size: 18px !important;
}


/* Sastojci tagovi */
.sastojci {
    position: fixed;
    top: 0;
    right: 0;
    left: 350px;
    z-index: 3;
    display: flex;
    flex-wrap: wrap;
    flex-direction: row-reverse;
    padding: 10px;
}

.chipMine {
    height: 35px;
    font-family: 'Cabin', sans-serif;
    letter-spacing: 0.05em;
}

@media only screen and (max-width: 900px) {
  .sastojci {
    left: 0;
  }
  .side {
    box-shadow: none !important;
  }
  .sastojci {
    top: 60px;
  }
}

@media only screen and (max-height: 700px) {
  .flexWrapper {
    flex: 1;
  }
  .links {
    display: none;
  }
  .side {
    padding-bottom: 0;
  }
}
</style>
