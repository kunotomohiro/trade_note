class User::WinRatesController < User::ApplicationController

  def index
    @trade = Trade.new(current_user_id: current_user.id)
    @day_trade = DayTrade.new(current_user_id: current_user.id)
    @swing_trade = SwingTrade.new(current_user_id: current_user.id)
    @scalping_trade = ScalpingTrade.new(current_user_id: current_user.id)
  end

end