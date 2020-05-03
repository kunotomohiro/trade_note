export default {
  data: {
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
  }
}