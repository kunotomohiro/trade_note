class User::TradeWinRatesController < User::ApplicationController

  def index
    year              = params[:trade_win_rate].nil? ? 2020 : params[:trade_win_rate][:year]
    @fx               = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 1, year: year)
    @stock            = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 2, year: year)
    @virtual_currency = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 3, year: year)
  end

end