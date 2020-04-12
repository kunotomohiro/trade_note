class Api::V1::InitialisationsController < Api::V1::ApplicationController

  def show
    @trade_styles     = TradeStyle.select("name", "id")
    @trade_categories = TradeCategory.select("name", "id")
    @results          = Trade.results.keys
    @user_id          = current_user.id

    respond_to do |format|
      format.json {render :json =>
        {
          trade_styles:     @trade_styles,
          trade_categories: @trade_categories,
          results:          @results,
          user_id:          @user_id
        }
      }
    end
  end

end