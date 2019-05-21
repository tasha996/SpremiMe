<template>
  <div>
    <v-form v-model="valid" ref="form" @submit.prevent="submit">
      <v-text-field
        color="#111" 
        v-model="email"
        label="E-mail" 
        type="email"
        :rules="emailRules"
        autocomplete="off"
        outline 
        required
      ></v-text-field>
      <v-text-field
        color="#111"
        v-model="password"
        :append-icon="show ? 'visibility_off' : 'visibility'"
        :type="show ? 'text' : 'password'"
        @click:append="show = !show"
        label="Password"
        :rules="passRules"
        outline 
        required
      ></v-text-field>
      <v-text-field 
        color="#111"
        v-model="fname"
        label="First Name" 
        type="text" 
        :rules="fnameRules"
        autocomplete="off"
        outline
      ></v-text-field>
      <v-text-field 
        color="#111"
        v-model="lname"
        label="Last Name" 
        type="text" 
        :rules="lnameRules"
        autocomplete="off"
        outline
      ></v-text-field>
      <v-menu
        ref="menu"
        :close-on-content-click="false"
        v-model="menu"
        :nudge-right="40"
        :return-value.sync="date"
        lazy
        transition="scale-transition"
        offset-y
        full-width
        min-width="290px"
      >
        <v-text-field
          color="#111"
          slot="activator"
          v-model="date"
          label="Date of birth"
          readonly
          outline
        ></v-text-field>
        <v-date-picker v-model="date" no-title scrollable color="#eaaa09">
          <v-spacer></v-spacer>
          <v-btn flat color="#111" @click="menu = false">Cancel</v-btn>
          <v-btn flat color="#111" @click="$refs.menu.save(date)">OK</v-btn>
        </v-date-picker>
      </v-menu>

    <v-layout justify-end flex align-end>
      <v-btn large flat block light color="#eaaa09"
      class="subheading mt-1"
      type="submit"
      >
        Sign Up
      </v-btn>
    </v-layout>
    </v-form>
  </div>
</template>

<script>
import ajax from '../http-common.js';

  export default {
    data: () => ({
      // date data
      date: new Date().toISOString().substr(0, 10),
      menu: false,
      modal: false,
      menu2: false,
      // form data
      valid: false,
      email: '',
      emailRules: [
        v => !!v || 'E-mail is required',
        v => /.+@.+/.test(v) || 'E-mail must be valid'
      ],
      show: false,
      password: '',
      passRules: [
        v => !!v || 'Password is required',
        v => v.length >= 8 || 'Password too short'
      ],
      fname: '',
      fnameRules: [
        v => !!v || 'First name is required'
      ],
      lname: '',
      lnameRules: [
        v => !!v || 'Last name is required'
      ],
    }),

    methods: {
    submit () {
      if (this.$refs.form.validate()) {
        console.log('Creating User');
        ajax.post('korisnik', {
          mail: this.email,
          pass: this.password,
          ime: this.fname,
          prezime: this.lname,
          date: this.date
        })
        .then(response => {
          // success, move to login and show message
          console.log(response);
          this.$router.push('login');
          this.$root.$emit('showMsg', 'Account created. Please login.');

        })
        .catch(e => {
          console.log(e.response.data);
          this.$root.$emit('showMsg', e.response.data);
        });
      }
    }
  }
  }
</script>