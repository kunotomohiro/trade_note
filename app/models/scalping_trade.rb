class ScalpingTrade < Trade

  # Fx
  def win_number_of_fx_scalping_trades
    win_number_of_fx_trades.where("trade_style_id" => 3).count
  end

  def fx_scalping_trades_win_rate
    return "0%" if win_number_of_fx_scalping_trades === 0
    "#{(win_number_of_fx_scalping_trades / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end

  # 株
  def win_number_of_stock_scalping_trades
    win_number_of_stock_trades.where("trade_style_id" => 3).count
  end

  def stock_scalping_trades_win_rate
    return "0%" if win_number_of_stock_scalping_trades === 0
    "#{(win_number_of_stock_scalping_trades / search_user_stock_trades.count.to_f * 100).floor(1)}%"
  end

  # 仮想通貨
  def win_number_of_virtual_currency_scalping_trades
    win_number_of_virtual_currency_trades.where("trade_style_id" => 3).count
  end

  def virtual_currency_scalping_trades_win_rate
    return "0%" if win_number_of_virtual_currency_scalping_trades === 0
    "#{(win_number_of_virtual_currency_scalping_trades / search_user_virtual_currency_trades.count.to_f * 100).floor(1)}%"
  end

end