class Api::V1::TradeWinRatesController < Api::V1::ApplicationController

  def index
    @fx = Trade
          .search_by_user_id(current_user)
          .search_by_trade_category(1)
          .search_by_result("資産増")
    respond_to do |format|
      format.json {render :json =>
        {
          fx: @fx
        }
      }
    end
  end

end