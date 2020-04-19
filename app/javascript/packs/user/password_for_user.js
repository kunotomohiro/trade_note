import Vue from 'vue/dist/vue.esm.js'; 

window.onload = function(){
  var passwordForUser = new Vue({
    el: "#password_for_user",
    data: {
      email: "",
      password: "",
      passwordConfirmation: "",
      isPush: true,
      passwordLength: false,
      characterCase:  false,
      includeNumber:  false,
      emailStatus:    false,
      passwordStatus: false,
      passwordConfirmationStatus: false
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
      },
      inputPassword() {

        self.password.length >= 8 ? self.passwordLength = true : self.passwordLength = false

        self.password.match(/(?=.*?[a-z])(?=.*?[A-Z])/) ? self.characterCase = true : self.characterCase = false

        self.password.match(/\d/) ? self.includeNumber = true : self.includeNumber = false

        if (self.passwordLength === true && self.characterCase === true && self.includeNumber === true){
          self.passwordStatus = true
        } else {
          self.passwordStatus = false
        }
        
        self.inputPasswordConfirmation()
        self.toggleIspush()
      },
      inputPasswordConfirmation() {
        if (self.passwordConfirmation === self.password && self.passwordConfirmation.length >= 1 ) {
          self.passwordConfirmationStatus = true
        } else {
          self.passwordConfirmationStatus = false
        }
        self.toggleIspush()
      },
      toggleIspush() {
        if (self.emailStatus === true && self.passwordStatus === true && self.passwordConfirmationStatus === true ) {
          self.isPush = false
        } else {
          self.isPush = true
        }
      }
    }
  })
}