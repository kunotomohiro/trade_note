class User::TradesController < User::ApplicationController
  before_action :set_trade_params, only: [:show, :edit]

  def index
    @trades = current_user.trades.all.order(id: :desc)
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

  private

  def set_trade_params
    @trade = current_user.trades.find(params[:id])
  end

end