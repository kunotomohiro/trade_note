import Vue           from 'vue';
import Notifications from 'vue-notification';
import superagent    from 'superagent';
import tradeForm from "../mixin/user/trade_form.js"

Vue.use(Notifications)
//see https://www.npmjs.com/package/vue-notification

const token = document.getElementsByName('csrf-token')[0].getAttribute('content')

window.onload = function(){
  var trade = new Vue({
    el: "#trade",
    mixins: [tradeForm],
    data: {
      errors: "",
      changeImage: true
    },
    created: function() {
      self = this
      superagent
      .get(`/api/v1/initialisations.json`)
      .set('X-CSRF-Token', token)
      .set('Accept', 'application/json')
      .end(function(error, data){
        trade.$data.trade_styles     = data.body.trade_styles
        trade.$data.trade_categories = data.body.trade_categories
        trade.$data.results          = data.body.results
        trade.$data.trade.user_id    = data.body.user_id
      })

      superagent
      .get(location.pathname + ".json")
      .set('X-CSRF-Token', token)
      .set('Accept', 'application/json')
      .end(function(error, data){
        trade.$data.trade = data.body.trade
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
         trade.$data.trade.image = e.target.result;
         trade.$data.trade_image = e.target.result;
         self.$forceUpdate()
       };
       reader.readAsDataURL(file);
      },
      update(id) {
        if (!confirm('本当に変更しますか？')){
          return
        }

        if (!trade.$data.trade.pips){
          self.errors = "pipsを入力して下さい";
          Vue.notify({
            group: 'information',
            type: 'warn',
            title: self.errors
          })
          return
        }

        superagent
        .put(`/user/trades/${id}`)
        .set('X-CSRF-Token', token)
        .set('Accept', 'application/json')
        .send({trade: self.trade})
        .end(function(error, data){
          if (data.created) {
            Vue.notify({
              group: 'information',
              type: 'success',
              title: '変更しました！',
              text: '',
            })
            location.href = (`/user/trades/${id}`)
          } else {
            Vue.notify({
              group: 'information',
              type: 'success',
              title: '変更しました！',
              text: '',
            })
            location.href = (`/user/trades/${id}`)
          }
        })
      },
      destroy(id) {
        if (!confirm('本当に削除しますか？')){
          return
        }

        superagent
        .delete(`/user/trades/${id}`)
        .set('X-CSRF-Token', token)
        .set('Accept', 'application/json')
        .send({trade: self.trade})
        .end(function(error, data){
          if (data.ok) {
            Vue.notify({
              group: 'information',
              type: 'success',
              title: '削除しました！',
              text: '',
            })
            location.href = (`/user/trades`)
          } else {
            Vue.notify({
              group: 'information',
              type: 'error',
              title: '削除に失敗しました！',
              text: '',
            })
          }
        })
      }
    }
  })
}