class TradeWinRate < Trade
  attr_accessor :trade_category_id
  def total_win_rate
    return "0%" if win_number_of_trades.count === 0
    "#{(win_number_of_trades.count / user_trades.count.to_f * 100).floor(1)}%"
  end

  def trade_style_win_rate(trade_style_id)
    return "0%" if win_number_of_trades.count === 0
    trades = win_number_of_trades.where("trade_style_id" => trade_style_id).count
    "#{(trades / user_trades.count.to_f * 100).floor(1)}%"
  end

  def total_win_rate_in_year
    return "0%" if win_number_of_trades_in_year.count === 0
    "#{(win_number_of_trades_in_year.count / user_trades_in_year.count.to_f * 100).floor(1)}%"
  end

  def trade_style_win_rate_in_year(trade_style_id)
    return "0%" if win_number_of_trades_in_year.count === 0
    trades = win_number_of_trades_in_year.where("trade_style_id" => trade_style_id).count
    "#{(trades / user_trades_in_year.count.to_f * 100).floor(1)}%"
  end

  def total_win_rate_in_month
    return "0%" if win_number_of_trades_in_month.count === 0
    "#{(win_number_of_trades_in_month.count / user_trades_in_month.count.to_f * 100).floor(1)}%"
  end

  def trade_style_win_rate_in_month(trade_style_id)
    return "0%" if win_number_of_trades_in_month.count === 0
    trades = win_number_of_trades_in_month.where("trade_style_id" => trade_style_id).count
    "#{(trades / user_trades_in_month.count.to_f * 100).floor(1)}%"
  end
end