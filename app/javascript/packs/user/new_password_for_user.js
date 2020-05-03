import Vue from 'vue';
import password from "../mixin/user/password.js"

window.onload = function(){
  var passwordForUser = new Vue({
    el: "#new_password_for_user",
    mixins: [password]
  })
}