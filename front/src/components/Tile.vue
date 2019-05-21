<template>
  <router-link tag="div" class="square" :to="`/recept/${id}`">
    <div class="tile">
      <img :src="require('@/assets/images/' + index + '.png')">
      <div class="tileInfo">
        <div>{{jelo.naziv}}</div>
        <div class="wrap">
          <div class="time">{{jelo.vreme}} min</div>
          <div class="actions" v-if="canDelete">
            <div class="sep"></div>
            <v-btn flat icon small :to="`/edit/${id}`">
              <v-icon>edit</v-icon>
            </v-btn>
            <v-btn flat icon small @click.stop="deleteRecept">
              <v-icon>delete</v-icon>
            </v-btn>
          </div>
        </div>
      </div>
    </div>
  </router-link>
</template>


<script>
import ajax from "../http-common.js";

export default {
	props: {
		id: {
			default: -1
    },
    index: {
      default: 1
    },
		canDelete: {
			default: false
		}
	},
	data() {
		return {
			jelo: {
				naziv: "",
				vreme: ""
			}
		};
	},
	methods: {
		loadRecept() {
			ajax.get("/recept/" + this.id)
			.then(res => {
				this.jelo.naziv = res.data.recept["naziv"];
				this.jelo.vreme = res.data.recept["vremePripreme"];
			})
			.catch(e => {
				console.log(e);
			});
    },
    deleteRecept() {
      this.$parent.promptDelete(this.id, this.jelo.naziv);
    }
	},
	mounted() {
		if (this.id != -1)
			this.loadRecept();
	}
};
</script>


<style scoped>
.square {
  position: relative;
  box-sizing: border-box;
  cursor: pointer;
}

.square:hover {
  box-shadow: 0 0 3px 2px rgba(0, 0, 0, 0.1);
  z-index: 1;
}

.square::before {
  content: "";
  display: block;
  padding-top: 100%;
  cursor: pointer;
}

.square .tile {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  border-right: 1px solid #eeeeee;
  border-bottom: 1px solid #eeeeee;
  background-color: #fff;
}
.tile img {
  width: 100%;
  height: 100%;
  padding: 30px;
}
.tileInfo {
  position: absolute;
  bottom: 0;
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
  padding-right: 5px;
}
.wrap {
  display: flex;
  align-items: center;
}
.time {
  margin-right: 20px;
}
.actions {
  display: flex;
  align-items: center;
}
.sep {
  width: 1px;
  height: 40px;
  margin-right: 10px;
  background-color: rgba(0, 0, 0, 0.1);
}
.square {
  flex-basis: calc(25%);
}
@media only screen and (max-width: 1500px) {
  .square {
    flex-basis: calc(33.333%);
  }
}
@media only screen and (max-width: 1200px) {
  .square {
    flex-basis: calc(50%);
  }
}
@media only screen and (max-width: 600px) {
  .square {
    flex-basis: calc(100%);
  }
}
</style>