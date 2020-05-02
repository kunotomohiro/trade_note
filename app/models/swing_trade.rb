class SwingTrade < Trade

  def win_number_of_fx_swing_trades
    win_number_of_fx_trades.where("trade_style_id" => 2).count
  end

  def fx_swing_trade_win_rate
    return "0%" if win_number_of_fx_swing_trades === 0
    "#{(win_number_of_fx_swing_trades / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end

  def win_number_of_stock_swing_trades
    win_number_of_stock_trades.where("trade_style_id" => 2).count
  end

  def stock_swing_trade_win_rate
    return "0%" if win_number_of_stock_swing_trades === 0
    "#{(win_number_of_stock_swing_trades / search_user_stock_trades.count.to_f * 100).floor(1)}%"
  end

end