class VirtualCurrency < Trade

  def search_user_virtual_currency_trades
    Trade.where("(user_id = ?) and (trade_category_id = ?)", current_user_id, 3)
  end

  def win_number_of_virtual_currency_trades
    search_user_virtual_currency_trades.where("result" => "資産増")
  end

  def win_number_of_virtual_currency_day_trades
    win_number_of_virtual_currency_trades.where("trade_style_id" => 1).count
  end

  def win_number_of_virtual_currency_swing_trades
    win_number_of_virtual_currency_trades.where("trade_style_id" => 2).count
  end

  def win_number_of_virtual_currency_scalping_trades
    win_number_of_virtual_currency_trades.where("trade_style_id" => 3).count
  end

  def virtual_currency_win_rate
    return "0%" if win_number_of_virtual_currency_trades.count === 0
    "#{(win_number_of_virtual_currency_trades.count / search_user_virtual_currency_trades.count.to_f * 100).floor(1)}%"
  end

  def virtual_currency_day_trade_win_rate
    return "0%" if win_number_of_virtual_currency_day_trades === 0
    "#{(win_number_of_virtual_currency_day_trades / search_user_virtual_currency_trades.count.to_f * 100).floor(1)}%"
  end

  def virtual_currency_swing_trade_win_rate
    return "0%" if win_number_of_virtual_currency_swing_trades === 0
    "#{(win_number_of_virtual_currency_swing_trades / search_user_virtual_currency_trades.count.to_f * 100).floor(1)}%"
  end

  def virtual_currency_scalping_trades_win_rate
    return "0%" if win_number_of_virtual_currency_scalping_trades === 0
    "#{(win_number_of_virtual_currency_scalping_trades / search_user_virtual_currency_trades.count.to_f * 100).floor(1)}%"
  end

end