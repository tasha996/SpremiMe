<template>
  <div class="jelo">
    <div class="side">
      <h2>Recept</h2>
      <div class="authorInfo">
        <div class="tile">
          <div class="tileInfo">
            <div>{{jelo.naziv}}</div>
            <div>{{jelo.vreme}} min</div>
          </div>
          <v-img
            :src="require('@/assets/images/' + fakeID + '.png')"
            position="center center"
            class="img"
            contain
          ></v-img>
        </div>
        <router-link tag="div" class="authorRec" :to="`/profil/${idKor}`">
          <div class="authorImg">
            <v-img
              :src="require('@/assets/images/chef.svg')"
              position="center center"
              class="chef elevation-3"
              contain
            ></v-img>
          </div>
          <p class="autor">
            <b>{{jelo.autor}}</b>
          </p>
          <p>"{{jelo.opis}}"</p>
        </router-link>
      </div>
    </div>
    <div class="side">
      <h2>Sastojci</h2>
      <div dark class="jeloSastojci">
        <v-list two-line>
          <template v-for="(item) in sastojci">
            <v-list-tile avatar :key="`s${item.id}`">
              <v-list-tile-avatar>
                <v-icon color="orange">label</v-icon>
              </v-list-tile-avatar>

              <v-list-tile-content>
                <v-list-tile-title>{{item.naziv}}</v-list-tile-title>
                <v-list-tile-sub-title class="text--primary">
                  <b>{{item.kol}}</b>
                  {{item.jed}}
                </v-list-tile-sub-title>
                <v-list-tile-sub-title>{{item.opis}}</v-list-tile-sub-title>
              </v-list-tile-content>

              <v-list-tile-action>
                <v-list-tile-action-text>Nutritivna vr: {{item.nv}}</v-list-tile-action-text>
                <v-checkbox color="orange"></v-checkbox>
              </v-list-tile-action>
            </v-list-tile>
            <v-divider :key="`sd${item.id}`"></v-divider>
          </template>
        </v-list>
      </div>
    </div>
    <div class="side koraci">
      <h2>Priprema</h2>
      <div class="jeloPriprema">
        <div class="korak" v-for="(item, index) in koraci" :key="`st${index}`">
          <v-avatar color="#333" class="elevation-3 av" size="30">
            <span class="white--text headline">{{index + 1}}</span>
          </v-avatar>
          <p>{{item}}</p>
        </div>
        <v-divider class="ma-3"></v-divider>
      </div>
      <div class="ocena">
        <div>Oceni moj recept:</div>
        <v-rating v-model="ocena" background-color="gray" color="orange" size="30"></v-rating>
      </div>
    </div>
  </div>
</template>

<script>
import ajax from "../http-common.js";

export default {
  components: {},
  props: {
    fakeID: {
      default: 1
    }
	},
  data() {
    return {
			idp: this.$route.params.idp,
      ocena: 3,
      jelo: {
        autor: "",
        naziv: "",
        vreme: null,
        datum: "",
        opis: ""
      },
      sastojci: [],
      koraci: [],
      idKor: ""
    };
  },
  methods: {
    loadRecept() {
      ajax
        .get("recept/" + this.idp)
        .then(res => {
          console.log(res.data);
          // load data
          this.jelo.autor =
            res.data.korisnik["ime"] + " " + res.data.korisnik["prezime"];
          this.jelo.naziv = res.data.recept["naziv"];
          this.jelo.vreme = res.data.recept["vremePripreme"];
          this.jelo.datum = res.data.datumKreiranja["datum"];
          this.jelo.opis = res.data.recept["opis"];
          this.koraci = res.data.recept["uputstvo"];
          this.idKor = res.data.idKor;

          for (let index = 0; index < res.data.sastojci.length; index++) {
            let s = {};
            s.naziv = res.data.sastojci[index].properties["naziv"];
            s.nv = res.data.sastojci[index].properties["nutritivnaVr"];
            s.id = res.data.sastojci[index].identity;
            s.kol = res.data.veze[index]["kolicina"];
            s.jed = res.data.veze[index]["jedinica"];
            s.opis = res.data.veze[index]["opis"];

            this.sastojci.push(s);
          }
        })
        .catch(e => {
          console.log(e);
        });
    }
  },
  mounted() {
    this.loadRecept();
  }
};
</script>

<style scoped>
.jelo {
  padding: 40px;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-evenly;
  font-family: Cabin;
  width: 100%;
}

.jelo .side {
  width: 400px;
  padding: 0 5px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.jelo h2 {
  font-family: Cabin;
  width: 250px;
  font-size: 28px;
  font-weight: 500;
  margin: 30px 0;
  padding-bottom: 20px;
  text-align: center;
  border-bottom: 2px solid orange;
}

.authorInfo {
  width: 100%;
}

.authorRec {
  position: relative;
  cursor: pointer;
}

.authorRec p {
  padding-left: 80px;
  font-style: italic;
}

.authorImg {
  position: absolute;
  left: 0;
  top: 5px;
}

.autor {
  font-style: normal !important;
  font-size: 16px;
  margin-bottom: 3px;
}

.jeloSastojci {
  width: 100%;
}

.jeloPriprema {
  width: 100%;
}

.korak {
  width: 100%;
  padding-bottom: 5px;
  position: relative;
}

.korak p {
  margin-top: 10px;
  padding-left: 45px;
}

.korak .av {
  position: absolute;
  left: 0px;
  top: 5px;
}

.korak span {
  font-family: Cabin !important;
  font-size: 20px !important;
}

/* ocena */
.ocena {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  padding: 10px 0px;
}

.ocena > div {
  font-size: 15px;
  font-weight: bold;
}

/* slika */
.chef {
  width: 70px;
  height: 70px;
  background-color: #eaaa09;
  border: 2px solid #111;
  border-radius: 50%;
}

.tile {
  position: relative;
}
.tile .img {
  width: 100%;
  max-width: 350px;
  /* border: 1px solid #11111111; */
  margin: 20px auto;
}
.tileInfo {
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
  background-color: #eeeeee;
  font-family: "Cabin", sans-serif;
  font-size: 14px;
  font-weight: 800;
  height: 42px;
  border-right: 4px solid #eaaa09;
  margin-bottom: 20px;
}

@media only screen and (max-width: 900px) {
  .jelo {
    display: block;
    padding: 20px;
  }
  .jelo .side {
    width: 100%;
  }
  .ocena {
    flex-direction: column;
  }
}

@media only screen and (max-width: 1700px) {
  .koraci {
      width: 100% !important;
      max-width: 800px;
  }
}
</style>

