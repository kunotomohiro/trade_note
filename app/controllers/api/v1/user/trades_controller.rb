class Api::V1::User::TradesController < User::ApplicationController
  before_action :set_trade_params, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:create, :update]

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

  def show
    respond_to do |format|
      format.json {render :json =>
        {
          trade: @trade
        }
      }
    end
  end

  def update
    respond_to do |format|
      if trade_params.present?
        @trade.update(trade_params.except(:image))
        @trade.base64upload(trade_params[:image])
        @trade.update(trade_params)
        format.html 
        format.json { render json: @trade, status: :created}
      else
        format.html
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_trade_params
    @trade = current_user.trades.find(params[:id])
  end

  def trade_params
    params.require(:trade).permit(
      :trade_style_id, :trade_category_id, :pips,       :content,
      :entry_time,     :exit_time,         :result,     :user_id,
      :image,          :created_at,        :updated_at, :id
    )
  end
end