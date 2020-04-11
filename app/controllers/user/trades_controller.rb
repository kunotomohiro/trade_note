class User::TradesController < User::ApplicationController
  before_action :set_trade_params, only: [:show, :edit, :destroy]

  def index
    @trades = current_user.trades.with_attached_image.order(id: :desc)
  end

  def new
    @trade = Trade.new
  end

  def show; end

  def edit
    respond_to do |format|
      format.html
      format.json { render :json => { trade: @trade } }
    end
  end

  def destroy
    if @trade.destroy
      redirect_to user_trades_path
    else
      render "show"
    end
  end

  private

  def set_trade_params
    @trade = current_user.trades.find(params[:id])
  end

end