class ScalpingTrade < Trade

  def win_number_of_fx_scalping_trades
    win_number_of_fx_trades.where("trade_style_id" => 3).count
  end

  def scalping_trades_win_rate
    return "0%" if win_number_of_fx_scalping_trades === 0
    "#{(win_number_of_fx_scalping_trades / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end

end