class DayTrade < Trade

  def win_number_of_fx_daytrades
    win_number_of_fx_trades.where("trade_style_id" => 1).count
  end

  def daytrade_win_rate
    return "0%" if win_number_of_fx_daytrades === 0
    "#{(win_number_of_fx_daytrades / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end
  
end