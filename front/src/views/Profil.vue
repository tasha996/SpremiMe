<template>
    <div class="profile">
        <h2>Kulinar</h2>
        <div class="top">
            <div class="side">
                <v-img
                    :src="require('@/assets/images/avatar.svg')"
                    position="center center"
                    class="img"
                    contain
                ></v-img>
            </div>
            <div class="infoTab side">
                <div class="infoSide">
                <div>Ime</div>
                <div>Prezime</div>
                <div>Email</div>
                <div>Recepti</div>
                </div>
                <div class="infoValues">
                <div>{{korisnik.ime}}</div>
                <div>{{korisnik.prezime}}</div>
                <div>{{korisnik.mail}}</div>
                <div>{{idRecepata.length}}</div>
                </div>
            </div>
        </div>
        <h2>Moji recepti</h2>
        <div class="recepti">
            <div class="layoutGrid">
                <tile v-for="(r,i) in idRecepata" :key="'t' + r" :id="Number(r)" :index="(i % 9) + 1" :canDelete="canDelete"></tile>
            </div>
        </div>

        <!-- Dialog for deleting -->
        <v-dialog v-model="dialog" max-width="300">
        <v-card class="pa-2">
            <v-card-title class="title">Obrisati {{tileNaziv}} recept?</v-card-title>
            <v-card-text>Ova opcija ce trajno izbrisati vas recept iz baze podataka i korisnici nece biti u mogucnosti da mu pristupe.</v-card-text>
            <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="orange" flat @click="dialog = false">Odustani</v-btn>
            <v-btn color="orange" flat @click="deleteTile(tileID)">Potvrdi</v-btn>
            </v-card-actions>
        </v-card>
        </v-dialog>
    </div>
</template>

<script>
import Tile from '@/components/Tile.vue'
import ajax from '../http-common.js';

export default {
    components: {
        Tile
    },
    data() {
        return {
            korisnik : {
                ime: '',
                prezime: '',
                mail: ''
            },
            idRecepata : [],
            idp: this.$route.params.idp,
            dialog: false,
            tileID: null,
            tileNaziv: null
        }
    },
    watch: {
        '$route.params.idp': function (idp) {
            this.idp = idp;
            this.loadKorisnik();
        }
    },
    computed: {
        canDelete() {
            return (this.idp == this.$root.user['id']);
        }
    },
    methods: {
        loadKorisnik() {
            ajax.get('korisnik/' + this.idp)
            .then(res => {
                // load data
                this.korisnik.ime = res.data.korisnik.properties['ime'] ;
                this.korisnik.prezime = res.data.korisnik.properties['prezime'];
                this.korisnik.mail = res.data.korisnik.properties['mail'];
                // id recepata
                this.idRecepata = res.data['recepti'];
            })
            .catch(e => {
                console.log(e);
            });
        },
        promptDelete(idTile, naziv) {
            console.log('pitam ' + idTile);
            this.tileID = idTile;
            this.tileNaziv = naziv;
            this.dialog = true;
        },
        deleteTile(idTile) {
            ajax.delete("/recept/" + this.tileID)
			.then(res => {
                this.$root.$emit('showMsg', 'Recept uklonjen');
                this.loadKorisnik();
			})
			.catch(e => {
				console.log(e);
			});
            this.dialog = false;
        }

    }, 
    mounted() {
        this.loadKorisnik();
    },     
}
</script>

<style scoped>

.infoTab {
  display: flex;
  margin-left: 0px;
  padding: 30px;
}

.infoTab > div > div {
  margin-bottom: 10px;
  font-size: 20px;
}

.infoSide {
  width: 100px;
  margin-right: 20px;
  font-family: Cabin;
}

.infoSide > div {
  font-weight: 400;
}

.infoValues > div {
  font-weight: 300;
  opacity: 0.6;
}

.layoutGrid {
    display: flex;
    flex-wrap: wrap;
}

h2 {
    font-family: Cabin;
    width: 250px;
    font-size: 28px;
    font-weight: 500;
    /* text-transform: uppercase; */
    margin: 30px auto;
    padding-bottom: 20px;
    text-align: center;
    border-bottom: 2px solid orange;
}

.top {
    padding: 40px;
    width: 100%;
    max-width: 800px;
    margin: auto;
    display: flex;
    justify-content: center;
    align-items: center;
}

.img {
    width: 200px;
    height: 200px;
    margin: 0 30px;
}

/* Responsive */
@media (max-width: 800px) {
  .profile {
    flex-direction: column;
  }
  .infoTab {
    margin: 0;
    padding-top: 20px;
  }
  .wrap {
    padding: 10px;
  }
}
@media (max-width: 600px) { 
    .top {
        width: 100%;
        flex-direction: column;
    }
    .img {
        margin-bottom: 20px;
    }
}

</style>