import Vue           from 'vue/dist/vue.esm.js';
import Notifications from 'vue-notification';
import ElementUI     from 'element-ui';
import               'element-ui/lib/theme-chalk/index.css';
import locale        from 'element-ui/lib/locale/lang/ja';
import superagent    from 'superagent';

Vue.use(ElementUI, { locale })
Vue.use(Notifications)
//see https://www.npmjs.com/package/vue-notification

const token = document.getElementsByName('csrf-token')[0].getAttribute('content')

window.onload = function(){
  var trade = new Vue({
    el: "#trade",
    data: {
      trade: {
        content: "",
        entry_time: "",
        exit_time: "",
        pips: "",
        user_id: "",
        image: "",
      },
      result: [],
      trade_styles: [],
      trade_categories: []
    },
    created: function() {
      superagent
      .get(`/api/v1/initialisations.json`)
      .set('X-CSRF-Token', token)
      .set('Accept', 'application/json')
      .end(function(error, data){
        trade.$data.trade_styles     = data.body.trade_styles
        trade.$data.trade_categories = data.body.trade_categories
        trade.$data.result           = data.body.result
        trade.$data.trade.user_id    = data.body.user_id
      })
    },
    methods: {
      submit() {
        superagent
        .post(`/api/v1/user/trades`)
        .set('X-CSRF-Token', token)
        .set('Accept', 'application/json')
        .send({trade: this.trade})
        .end(function(error, data){
          if (data.created) {
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
      },
      selectImage: function(event){
        let files = event.target.files
        this.createHostProfileImage(files[0]);
      },
      createHostProfileImage(file) {
        let reader = new FileReader();
        reader.onload = (e) => {
         trade.$data.trade.image = e.target.result;
         this.$forceUpdate()
       };
       reader.readAsDataURL(file);
      },
    }
  })
}