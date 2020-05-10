class User::WinRatesController < User::ApplicationController

  def index
    @fx = Fx.new(current_user_id: current_user.id, trade_category_id: 1)
    @stock = Stock.new(current_user_id: current_user.id, trade_category_id: 2)
    @virtual_currency = VirtualCurrency.new(current_user_id: current_user.id, trade_category_id: 3)
  end

end