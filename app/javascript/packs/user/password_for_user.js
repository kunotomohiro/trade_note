import Vue from 'vue/dist/vue.esm.js'; 
import password from "../mixin/user/password.js"

window.onload = function(){
  var passwordForUser = new Vue({
    el: "#password_for_user",
    mixins: [password],
    data: {
      email: "",
      emailStatus:    false
    },
    created: function() {
      self = this
    },
    methods: {
      inputEmail() {
        if (self.email.match(/^[A-Za-z0-9]{1}[A-Za-z0-9_.-\\+]*@{1}[A-Za-z0-9_.-]{1,}\.[A-Za-z0-9]{1,}$/)) {
          self.emailStatus = true
        } else {
          self.emailStatus = false
        }
        self.toggleIspush()
      }
    }
  })
}