import Vue from 'vue';

window.onload = function(){
  var win_rate = new Vue({
    el: "#win_rate",
    data: {
      displayWinRate: [true, true, true]
    },
    methods: {
      toggleDisplayWinRate(trade_category) {
        this.$set(
          this.displayWinRate,
          trade_category,
          (this.displayWinRate[trade_category] = !this.displayWinRate[trade_category])
        )
      }
    }
  })
}