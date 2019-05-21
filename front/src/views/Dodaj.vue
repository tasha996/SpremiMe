<template>
    <v-form ref="form">
    <div class="dodaj">
        <div class="side">
            <h2>Recept</h2>
            <div class="form">
                <v-img
                    :src="require('@/assets/images/' + fakeID + '.png')"
                    position="center center"
                    class="img"
                    contain
                ></v-img>
                <v-text-field
                    color="#111" 
                    label="Naziv"
                    autocomplete="off"
                    required
                    outline
                    v-model="naziv"
                ></v-text-field>
                <v-textarea
                    label="Kratak Opis"
                    hint="Opisite zasto volite ovaj recept"
                    outline
                    color="#111"
                    v-model="opis"
                ></v-textarea>
                <v-select
                    :items="tipovi"
                    label="Vrsta Jela"
                    outline
                    color="#111"
                    v-model="vrsta"
                ></v-select>
                <v-text-field
                    label="Vreme"
                    type="number"
                    suffix="min"
                    outline
                    color="#111"
                    v-model="vreme"
                ></v-text-field>
            </div>
        </div>
        <div class="side">
            <!-- Sastojci -->
            <h2 class="h2">Sastojci</h2>
            <div class="novi form">
                <v-text-field
                    color="#111" 
                    label="Dodaj Sastojak"
                    autocomplete="off"
                    required
                    outline
                    class="mr-3"
                    v-model="noviNaziv"
                ></v-text-field>
                <v-text-field
                    label="Nutritivna"
                    type="number"
                    suffix="vr"
                    outline
                    color="#111"
                    class="mr-3"
                    v-model="noviNutrin"
                ></v-text-field>
                <v-btn fab small color="orange" @click="kreirajSastojak">
                    <v-icon size=20 dark>add</v-icon>
                </v-btn>
            </div>
            <div class="form">
                <v-autocomplete class="search"
                    :loading="loading"
                    outline
                    color="#111"
                    prepend-inner-icon="search"
                    solo-inverted
                    label="Pretraga Sastojaka"
                    full-width
                    :items="items"
                    :search-input.sync="search"
                    item-text="naziv"
                    item-value="info"
                    v-model="select"
                    hide-no-data
                    hide-details
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
                <v-divider class="mt-4"></v-divider>
            </div>
            <div class="listaSastojaka ">
                <div v-for="(s) in sastojciForma" :key="`sd${s.id}`">
                    <v-list-tile avatar> 
                        <v-list-tile-avatar>
                            <v-icon color="orange">label</v-icon>
                        </v-list-tile-avatar>

                        <v-list-tile-content>
                            <v-list-tile-title>{{s.naziv}}</v-list-tile-title>
                            <v-list-tile-sub-title class="opac">Nutritivna vr: <b>{{s.nv}}</b></v-list-tile-sub-title>
                        </v-list-tile-content>

                        <v-list-tile-action>
                            <v-btn icon ripple @click="remSastojak(s)">
                                <v-icon color="grey lighten-1">delete</v-icon>
                            </v-btn>
                        </v-list-tile-action>
                    </v-list-tile>
                    <div class="novi form">
                        <v-text-field
                            label="Kolicina"
                            type="number"
                            outline
                            color="#111"
                            class="mr-3"
                            v-model="s.kol"
                        ></v-text-field>
                        <v-text-field
                            color="#111" 
                            label="Jedinica"
                            autocomplete="off"
                            required
                            outline
                            v-model="s.jed"
                        ></v-text-field>
                    </div>
                    <div class="form">
                        <v-textarea
                            label="Opis"
                            hint="Opisite stanje sastojka"
                            outline
                            color="#111"
                            rows=1
                            auto-grow
                            v-model="s.opis"
                        ></v-textarea>
                    </div>
                    <v-divider></v-divider>
                </div>
            </div>
        </div>
        <div class="side koraci">
            <h2>Koraci</h2>
            <div class="korak" v-for="(k, i) in koraci" :key="'k' + i">
                <v-avatar color="#333" class="elevation-3 av" size=30>
                    <span class="white--text headline">{{i + 1}}</span>
                </v-avatar>
                <v-textarea
                    label="Uputsvo"
                    hint="Korak u Receptu"
                    outline
                    color="#111"
                    rows=1
                    auto-grow
                    append-icon="delete"
                    @click:append="remKorak(i)"
                    v-model="koraci[i]"
                ></v-textarea>
            </div>
            <!-- <v-btn fab color="orange" @click="addKorak">
                <v-icon dark>add</v-icon>
            </v-btn> -->
            <v-btn @click="addKorak" large color="orange">
                Dodaj
            </v-btn>

            <!-- Save -->
            <v-btn v-if="!edit" to="" fab color="orange" large fixed bottom right @click="kreirajRecept">
                <v-icon>done</v-icon>
            </v-btn>
            <!-- Edit -->
            <v-btn v-if="edit" to="" fab color="orange" large fixed bottom right @click="izmeniRecept">
                <v-icon>edit</v-icon>
            </v-btn>
        </div>
    </div>
    </v-form>
</template>

<script>
import ajax from '../http-common.js';

export default {
    props: {
		edit: {
			default: false
        },
        fakeID: {
            default: 1
        }
	},
    data() {
        return {
            tipovi: ['Predjelo', 'Glavno Jelo', 'Desert'],
            koraci: ['', '', '', ''],
            sastojciForma: [],
            noviNaziv: '',
            noviNutrin: '',
            // search
            loading: false,
            items: [],
            search: null,
            select: null,
            sastojci: [],
            // forma
            naziv: '',
            opis: '',
            vrsta: '',
            vreme: '',
            // edit
            id: this.$route.params.idp,
        }
    },
    watch: {
        $route (to, from){
            // reset vrednosti
            if (to.path == "/dodaj") {
                this.koraci = ['', '', '', ''];
                this.sastojciForma = [];
                this.noviNaziv = '';
                this.noviNutrin = '';
                this.sastojci = '';
                this.naziv = '';
                this.opis = '';
                this.vrsta = '';
                this.vreme = '';
            } else {
                // druga izmena
                console.log('druga izmena');
            }
        },
        search (val) {
            val && val !== this.select && this.searchSastojke(val, this);
            val && val !== this.select && (this.loading = true);
        },
        select (val) {
            // dodaj u sastojke
            if (val!= null && val != '') {
                // proveri da li postoji
                let pass = true;
                this.sastojciForma.forEach(el => {
                    if (val.id == el.id)
                        pass = false;
                });
                // dopuni vrednost
                if (pass) {
                    this.sastojciForma.push({
                        naziv: val.name,
                        nv: val.nv,
                        id: val.id,
                        jed: '',
                        kol: '',
                        opis: '',
                    });
                }
                // resetuj formu
                this.$nextTick(() => {
                    this.select = '';
                });
            }   
        },
    },
    methods: {
        addKorak() {
            this.koraci.push('');
        },
        remKorak(index) {
            this.koraci.splice(index, 1);
        },
        remSastojak(s) {
            // obrisi sastojak u nizu
            console.log('removing');
            let index = this.sastojciForma.indexOf(s);
            if (index > -1) {
                this.sastojciForma.splice(index, 1);
            }
        },
        kreirajSastojak() {
            console.log(this.noviNaziv + " " + this.noviNutrin);
            // provera validnosti
            if (this.noviNaziv == '' || this.noviNutrin == '') {
                this.$root.$emit('showMsg', 'Nevalidan Sastojak');
                return;
            }
            // ubaci u bazu
            ajax.post('sastojak', {
                naziv: this.noviNaziv,
                nutritivnaVr: this.noviNutrin
            })
            .then(res => {
                console.log(res.data);
                this.$root.$emit('showMsg', 'Sastojak Kreiran');
                // ocisti deo forme
                this.noviNaziv = '';
                this.noviNutrin = '';
            })
            .catch(e => {
                console.log(e);
                this.$root.$emit('showMsg', e.response.data);
            });
        },
        // Search
        searchSastojke: _.debounce((v, that) => {
            that.loadSastojke(v);
        }, 500),
        loadSastojke(v) {
            ajax.get("/searchString?sub=" + v)
            .then(res => {
                this.items = [];
                // prikazi rezultate
                this.loading = false;
                res.data.forEach(el => {
                    this.items.push({
                        naziv: el.naziv,
                        nv: el.nv,
                        info: { id: el.id, name: el.naziv, nv: el.nv }
                    });
                });
            })
            .catch(e => {
                console.log(e);
            });
        },
        kreirajRecept() {
            // validacija forme
            if (this.naziv == '' || this.opis == '' || this.vrsta == '' || this.vreme == '') {
                this.$root.$emit('showMsg', 'Nevalidni Podaci');
                return;
            }
            // validacija niza koraka
            let valid = true;
            this.koraci.forEach(el => {
                if (el == '')
                    valid = false;
            });
            if (!valid) {
                this.$root.$emit('showMsg', 'Popunite Korake');
                return;
            }
            // priprema za slanje
            console.log(this.sastojciForma);

            // ubaci u bazu
            ajax.post('recept', {
                naziv: this.naziv,
                idKor: this.$root.user['id'],
                vremePripreme: this.vreme,
                opis: this.opis,
                uputstvo: this.koraci,
                sastojci: this.sastojciForma,
                vrsta: this.vrsta
            })
            .then(res => {
                console.log(res.data);
                this.$root.$emit('showMsg', 'Recept Kreiran');
                // predji na glavnu stranu
                this.$router.push('/recepti');
            })
            .catch(e => {
                console.log(e);
                this.$root.$emit('showMsg', e.response.data);
            });
        },
        izmeniRecept() {
            console.log('menjam');
            // validacija forme
            if (this.naziv == '' || this.opis == '' || this.vrsta == '' || this.vreme == '') {
                this.$root.$emit('showMsg', 'Nevalidni Podaci');
                return;
            }
            // validacija niza koraka
            let valid = true;
            this.koraci.forEach(el => {
                if (el == '')
                    valid = false;
            });
            if (!valid) {
                this.$root.$emit('showMsg', 'Popunite Korake');
                return;
            }
            // izmeni recept
            ajax.put('recept/' + this.id, {
                naziv: this.naziv,
                idKor: this.$root.user['id'],
                vremePripreme: this.vreme,
                opis: this.opis,
                uputstvo: this.koraci,
                sastojci: this.sastojciForma,
                vrsta: this.vrsta
            })
            .then(res => {
                console.log(res.data);
                this.$root.$emit('showMsg', 'Recept Izmenjen');
                // vrati se na profil
                this.$router.push('/profil/' + this.$root.user['id']);
            })
            .catch(e => {
                console.log(e);
                this.$root.$emit('showMsg', e.response.data);
            });
        },
        loadRecept() {
            console.log('menjanje');
            ajax.get("recept/" + this.id)
            .then(res => {
                // load data
                this.naziv = res.data.recept["naziv"];
                this.vreme = res.data.recept["vremePripreme"];
                this.opis = res.data.recept["opis"];
                this.koraci = res.data.recept["uputstvo"];
                // nadji vrstu jela
                let vr = res.data.vrsta;
                let index = this.tipovi.indexOf(vr);
                if (index > -1) {
                    this.vrsta = vr;
                } else {
                    this.vrsta = this.tipovi[1];
                }

                for (let index = 0; index < res.data.sastojci.length; index++) {
                    let s = {};
                    s.naziv = res.data.sastojci[index].properties["naziv"];
                    s.nv = res.data.sastojci[index].properties["nutritivnaVr"];
                    s.id = res.data.sastojci[index].identity;
                    s.kol = res.data.veze[index]["kolicina"];
                    s.jed = res.data.veze[index]["jedinica"];
                    s.opis = res.data.veze[index]["opis"];

                    this.sastojciForma.push(s);
                    this.sastojci.push(s.id);
                }
            })
            .catch(e => {
                console.log(e);
            });
        }
    },
    mounted() {
        if (this.edit) {
            // load recept to edit
            this.loadRecept();
        }
    }
}
</script>

<style scoped>
.dodaj {
    padding: 40px 40px;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-evenly;
    font-family: Cabin;
    width: 100%;
}
.side {
    width: 400px;
    display: flex;
    flex-direction: column;
    align-items: center;
}
h2 {
    font-family: Cabin;
    width: 250px;
    font-size: 28px;
    font-weight: 500;
    /* text-transform: uppercase; */
    margin: 30px 0;
    padding-bottom: 20px;
    text-align: center;
    border-bottom: 2px solid orange;
}
.h2 {
    margin: 30px auto;
}
.img {
    width: 100%;
    max-width: 300px;
    margin: auto;
    border: 1px solid #11111111;
    margin-bottom: 25px;
}
.form {
    width: 100%;
    padding: 5px;
}
.searchWrap {
    width: 100%;
}
.novi {
    display: flex;
}
.opac {
    opacity: 0.6;
}
.korak {
    width: 100%;
    position: relative;
    padding-left: 50px;
}
.korak .av {
    position: absolute;
    left: 0px;
    top: 15px;
}
.korak span {
    font-family: Cabin !important;
    font-size: 20px !important;
}

.save {
    width: 100%;
    margin-top: 30px;
}

@media only screen and (max-width: 1700px) {
  .koraci {
      width: 100%;
      max-width: 800px;
  }
}

@media only screen and (max-width: 900px) {
  .side {
      width: 100%;
  }
}

@media only screen and (max-width: 600px) {
  .dodaj {
      padding: 20px;
  }
}

</style>


