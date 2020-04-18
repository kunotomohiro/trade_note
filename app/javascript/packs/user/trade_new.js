import Vue           from 'vue';
import Notifications from 'vue-notification';
import superagent    from 'superagent';

Vue.use(Notifications)
//see https://www.npmjs.com/package/vue-notification

const token = document.getElementsByName('csrf-token')[0].getAttribute('content')

window.onload = function(){
  var trade = new Vue({
    el: "#trade",
    data: {
      errors: [],
      trade: {
        content: "",
        entry_time: "",
        exit_time: "",
        pips: "",
        user_id: "",
        image: "",
        result: "資産増",
        trade_style_id: ""
      },
      trade_image: "/img/nophoto_rectangle.jpg",
      results: [],
      trade_styles: [],
      trade_categories: [],
      datePickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now()
        }
      }
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
    },
    methods: {
      submit() {
        trade.$data.errors = [];
        if (!trade.$data.trade.image){
          this.errors.push('画像を入力して下さい');
        }
        if (!trade.$data.trade.pips){
          this.errors.push('pipsを入力して下さい');
        }
        if (!trade.$data.trade.exit_time){
          this.errors.push('決済日時を入力して下さい');
        }
        if (!trade.$data.trade.entry_time){
          this.errors.push('エントリー日時を入力して下さい');
        }
        if (!trade.$data.trade.trade_category_id){
          this.errors.push('カテゴリーを入力して下さい');
        }
        if (!trade.$data.trade.trade_style_id) {
          this.errors.push('トレードスタイルを入力して下さい');
        }

        if (trade.$data.errors.length) {
          for (let i = 0;  i < trade.$data.errors.length;  i++ ) {
            this.$notify({
              group: 'information',
              type: 'warn',
              title: trade.$data.errors[i]
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
        .post(`/user/trades`)
        .set('X-CSRF-Token', token)
        .set('Accept', 'application/json')
        .send({trade: self.trade})
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
      },
      selectImage: function(event){
        let files = event.target.files
        self.createTradeImage(files[0]);
      },
      createTradeImage(file) {
        let reader = new FileReader();
        reader.onload = (e) => {
         trade.$data.trade.image = e.target.result;
         trade.$data.trade_image = e.target.result;
         self.$forceUpdate()
       };
       reader.readAsDataURL(file);
      }
    }
  })
}