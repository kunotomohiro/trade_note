class Api::V1::User::TradesController < User::ApplicationController
  before_action :set_trade_params, only: [:edit, :update, :destroy]
  protect_from_forgery :except => [:create]

  def create
    @trade = Trade.new(trade_params.except(:image))
    @trade.base64upload(trade_params[:image])
    respond_to do |format|
      if @trade.save
        format.html 
        format.json { render json: @trade, status: :created}
      else
        format.html
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
  end

  def destroy
    
  end

  private

  def set_trade_params
    @trade = current_user.trades.find.find(params[:id])
  end

  def trade_params
    params.require(:trade).permit(
      :trade_style_id, :trade_category_id, :pips,      :content,
      :entry_time,     :exit_time,         :result,    :user_id,
      :image
    )
  end
end