import Vue        from 'vue';
import superagent from 'superagent';

const token = document.getElementsByName('csrf-token')[0].getAttribute('content')

window.onload = function(){
  var win_rate = new Vue({
    el: "#win_rate",
    data: {
      displayWinRate: [true, true, true],
      fx: []
    },
    methods: {
      toggleDisplayWinRate(trade_category) {
        this.$set(
          this.displayWinRate,
          trade_category,
          (this.displayWinRate[trade_category] = !this.displayWinRate[trade_category])
        )
      },
      search() {
        superagent
        .get(`/api/v1/trade_win_rates.json`)
        .set('X-CSRF-Token', token)
        .set('Accept', 'application/json')
        .end(function(error, data){
          win_rate.$data.fx = data.body.fx
        })
      }
    }
  })
}