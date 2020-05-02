class Fx < Trade

  def search_user_fx_trades
    Trade.where("(user_id = ?) and (trade_category_id = ?)", current_user_id, 1)
  end
  
  def win_number_of_fx_trades
    search_user_fx_trades.where("result" => "資産増")
  end

  def win_number_of_fx_day_trades
    win_number_of_fx_trades.where("trade_style_id" => 1).count
  end

  def win_number_of_fx_swing_trades
    win_number_of_fx_trades.where("trade_style_id" => 2).count
  end

  def win_number_of_fx_scalping_trades
    win_number_of_fx_trades.where("trade_style_id" => 3).count
  end

  def fx_win_rate
    return "0%" if win_number_of_fx_trades.count === 0
    "#{(win_number_of_fx_trades.count / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end

  def fx_day_trade_win_rate
    return "0%" if win_number_of_fx_day_trades === 0
    "#{(win_number_of_fx_day_trades / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end

  def fx_swing_trade_win_rate
    return "0%" if win_number_of_fx_swing_trades === 0
    "#{(win_number_of_fx_swing_trades / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end

  def fx_scalping_trades_win_rate
    return "0%" if win_number_of_fx_scalping_trades === 0
    "#{(win_number_of_fx_scalping_trades / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end

end