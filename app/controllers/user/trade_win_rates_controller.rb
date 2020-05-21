class User::TradeWinRatesController < User::ApplicationController

  def index
    year              = params[:trade_win_rate].nil? || params[:trade_win_rate][:year].nil? ? Time.now.strftime("%Y") : params[:trade_win_rate][:year]
    month_rate_year   = params[:trade_win_rate].nil? || params[:trade_win_rate][:month_rate_year].nil? ? Time.now.strftime("%Y") : params[:trade_win_rate][:month_rate_year]
    month             = params[:trade_win_rate].nil? || params[:trade_win_rate][:month].nil? ? Time.now.strftime("%m").delete("0") : params[:trade_win_rate][:month]
    @fx               = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 1, year: year)
    @stock            = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 2, year: year)
    @virtual_currency = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 3, year: year)
    @fx_in_month      = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 1, month_rate_year: month_rate_year, month: month)
    @stock_in_month   = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 2, month_rate_year: month_rate_year, month: month)
    @virtual_currency_in_month = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 3, month_rate_year: month_rate_year, month: month)
  end

end