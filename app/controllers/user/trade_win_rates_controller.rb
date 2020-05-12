class User::TradeWinRatesController < User::ApplicationController

  def index
    @fx = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 1)
    @stock = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 2)
    @virtual_currency = TradeWinRate.new(current_user_id: current_user.id, trade_category_id: 3)
  end

end