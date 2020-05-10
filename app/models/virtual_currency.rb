class VirtualCurrency < Trade

  def search_user_virtual_currency_trades
    Trade.where("(user_id = ?) and (trade_category_id = ?)", current_user_id, 3)
  end

  def win_number_of_virtual_currency_trades
    search_user_virtual_currency_trades.where("result" => "資産増")
  end

  def total_win_rate
    return "0%" if win_number_of_virtual_currency_trades.count === 0
    "#{(win_number_of_virtual_currency_trades.count / search_user_virtual_currency_trades.count.to_f * 100).floor(1)}%"
  end

  def trade_style_win_rate(trade_style_id)
    return "0%" if win_number_of_virtual_currency_trades === 0
    trades = win_number_of_virtual_currency_trades.where("trade_style_id" => trade_style_id).count
    "#{(trades / search_user_virtual_currency_trades.count.to_f * 100).floor(1)}%"
  end

end