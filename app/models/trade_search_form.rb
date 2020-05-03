class TradeSearchForm
  include ActiveModel::Model

  attr_accessor :trade_category_id, :trade_style_id,    :min_pips,      :max_pips,
                :min_entry_time,    :max_entry_time,    :min_exit_time, :max_exit_time,
                :exit_time,         :result,            :user_id

  def search
    Trade
      .with_attached_image
      .search_by_user_id(user_id)
      .search_by_trade_category(trade_category_id)
      .search_by_trade_style(trade_style_id)
      .search_by_min_pips(min_pips)
      .search_by_max_pips(max_pips)
      .search_by_uppere_entry_time(min_entry_time)
      .search_by_lower_entry_time(max_entry_time)
      .search_by_uppere_exit_time(min_exit_time)
      .search_by_lower_exit_time(max_exit_time)
      .search_by_result(result)
  end
  
end