class User::WinRatesController < User::ApplicationController

  def index
    @fx = Fx.new(current_user_id: current_user.id)
    @stock = Stock.new(current_user_id: current_user.id)
    @virtual_currency = VirtualCurrency.new(current_user_id: current_user.id)
  end

end