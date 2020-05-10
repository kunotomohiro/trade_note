class Fx < Trade

  def search_user_fx_trades
    Trade.where("(user_id = ?) and (trade_category_id = ?)", current_user_id, 1)
  end
  
  def win_number_of_fx_trades
    search_user_fx_trades.where("result" => "資産増")
  end

  def total_win_rate
    return "0%" if win_number_of_fx_trades.count === 0
    "#{(win_number_of_fx_trades.count / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end

  def trade_style_win_rate(trade_style_id)
    return "0%" if win_number_of_fx_trades === 0
    trades = win_number_of_fx_trades.where("trade_style_id" => trade_style_id).count
    "#{(trades / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end

  def search_user_fx_trades_in_year
    search_trades_between_year.where("(user_id = ?) and (trade_category_id = ?)", current_user_id, 1)
  end

  def win_number_of_fx_trades_in_year
    search_trades_between_year.search_trades_between_year.where("result" => "資産増")
  end

end