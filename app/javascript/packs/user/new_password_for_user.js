import Vue from 'vue';

window.onload = function(){
  var passwordForUser = new Vue({
    el: "#new_password_for_user",
    data: {
      password: "",
      passwordConfirmation: "",
      isPush: true,
      passwordLength: false,
      characterCase:  false,
      includeNumber:  false,
      passwordStatus: false,
      passwordConfirmationStatus: false
    },
    created: function() {
      self = this
    },
    methods: {
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
        if (self.passwordStatus === true && self.passwordConfirmationStatus === true ) {
          self.isPush = false
        } else {
          self.isPush = true
        }
      }
    }
  })
}