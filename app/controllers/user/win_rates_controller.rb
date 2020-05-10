class User::WinRatesController < User::ApplicationController

  def index
    @fx = Trade.new(current_user_id: current_user.id, trade_category_id: 1)
    @stock = Trade.new(current_user_id: current_user.id, trade_category_id: 2)
    @virtual_currency = Trade.new(current_user_id: current_user.id, trade_category_id: 3)
  end

end