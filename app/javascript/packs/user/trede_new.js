import Vue from 'vue';
import Notifications from 'vue-notification';

Vue.use(Notifications)
//see https://www.npmjs.com/package/vue-notification

const token = document.getElementsByName('csrf-token')[0].getAttribute('content')

window.onload = function(){
  var trade = new Vue({
    el: "",
    data: {

    }
  })
}