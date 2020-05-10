class VirtualCurrency < Trade

  def trade_style_win_rate(trade_style_id)
    return "0%" if win_number_of_trades === 0
    trades = win_number_of_trades.where("trade_style_id" => trade_style_id).count
    "#{(trades / user_trades.count.to_f * 100).floor(1)}%"
  end

end