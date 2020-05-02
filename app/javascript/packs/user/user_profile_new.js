import Vue           from 'vue';
import Notifications from 'vue-notification';
import superagent    from 'superagent';
import profileForm from "../mixin/user/profile_form.js"

Vue.use(Notifications)
//see https://www.npmjs.com/package/vue-notification

const token = document.getElementsByName('csrf-token')[0].getAttribute('content')

window.onload = function(){
  var user_profile = new Vue({
    el: "#user_profile",
    mixins: [profileForm],
    created: function() {
      self = this
    },
    methods: {
      selectImage: function(event){
        let files = event.target.files
        self.createUserAvatar(files[0]);
      },
      createUserAvatar(file) {
        let reader = new FileReader();
        reader.onload = (e) => {
         user_profile.$data.user_profile.avatar  = e.target.result;
         user_profile.$data.avatar               = e.target.result;
         self.$forceUpdate()
       };
       reader.readAsDataURL(file);
      },
      submit() {
        user_profile.$data.errors = [];
        if (!user_profile.$data.user_profile.nickname){
          this.errors.push('ニックネームを入力して下さい');
        }
        if (!user_profile.$data.user_profile.avatar){
          this.errors.push('画像を入力して下さい');
        }
        if (user_profile.$data.user_profile.nickname.length > 8 ){
          this.errors.push('ニックネームは８文字以内にしてください');
        }

        if (user_profile.$data.errors.length) {
          for (let i = 0;  i < user_profile.$data.errors.length;  i++ ) {
            this.$notify({
              group: 'information',
              type: 'warn',
              title: user_profile.$data.errors[i]
            })
          }
          this.$notify({
            group: 'information',
            type: 'error',
            title: '入力内容をご確認下さい。'
          })
          return
        }
        
        superagent
        .post(`/user/user_profile`)
        .set('X-CSRF-Token', token)
        .set('Accept', 'application/json')
        .send({user_profile: self.user_profile})
        .end(function(error, data){
          if (data.created) {
            Vue.notify({
              group: 'information',
              type: 'success',
              title: '登録しました！',
              text: '',
            })
            location.replace('/')
          } else {
            Vue.notify({
              group: 'information',
              type: 'error',
              title: '登録に失敗しました',
              text: '',
            })
          }
        })
      }
    }
  })
}