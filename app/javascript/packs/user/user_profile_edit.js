import Vue           from 'vue';
import Notifications from 'vue-notification';
import superagent    from 'superagent';

Vue.use(Notifications)
//see https://www.npmjs.com/package/vue-notification

const token = document.getElementsByName('csrf-token')[0].getAttribute('content')

window.onload = function(){
  var user_profile = new Vue({
    el: "#user_profile",
    data: {
      user_profile: {
        nickname: "",
        avatar: ""
      },
      changeImage: true,
      avatar: "/img/noface.png"
    },
    created: function() {
      self = this
      superagent
        .get(location.pathname + ".json")
        .set('X-CSRF-Token', token)
        .set('Accept', 'application/json')
        .send({user_profile: self.user_profile})
        .end(function(error, data){
          user_profile.$data.user_profile = data.body.user_profile
        })
    },
    methods: {
      selectImage: function(event){
        let files = event.target.files
        self.createTradeImage(files[0]);
        self.changeImage = false
      },
      createTradeImage(file) {
        let reader = new FileReader();
        reader.onload = (e) => {
         user_profile.$data.user_profile.avatar  = e.target.result;
         user_profile.$data.avatar               = e.target.result;
         self.$forceUpdate()
       };
       reader.readAsDataURL(file);
      },
      submit() {
        superagent
        .put(`/user/user_profile`)
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
            location.replace('/')
          }
        })
      }
    }
  })
}