class User::WinRatesController < User::ApplicationController

  def index
    @trade = Trade.new(current_user_id: current_user.id)
    @fx = Fx.new(current_user_id: current_user.id)
    @stock = Stock.new(current_user_id: current_user.id)
    @virtual_currency = VirtualCurrency.new(current_user_id: current_user.id)
  end

end