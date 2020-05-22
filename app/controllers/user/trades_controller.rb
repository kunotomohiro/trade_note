class User::TradesController < User::ApplicationController
  before_action :set_trade_params, only: [:show, :edit, :update, :destroy]
  before_action :trade_user?,      only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:create, :update]

  def index
    @trade_search_form = TradeSearchForm.new(trade_search_params)
    @trade_search_form.user_id = current_user.id
    @trades = @trade_search_form.search
              .order(id: :desc)
              .page(params[:page])
              .per(4)
  end

  def new
    @trade = Trade.new
  end

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

  def show;end

  def edit
    respond_to do |format|
      format.html
      format.json { render :json => { trade: @trade } }
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

  def destroy
    respond_to do |format|
      if @trade.destroy
        format.html
        format.json { render json: @trade, status: :ok }
      else
        format.html
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_trade_params
    @trade = Trade.find(params[:id])
  end

  def trade_user?
    unless @trade.user === current_user
      redirect_to user_trades_path
    end
  end

  def trade_params
    params.require(:trade).permit(
      :trade_style_id, :trade_category_id, :pips,       :content,
      :entry_time,     :exit_time,         :result,     :user_id,
      :image,          :created_at,        :updated_at, :id
    )
  end

  def trade_search_params
    return if params[:trade_search_form].blank?
    params.require(:trade_search_form).permit(
      :trade_category_id, :trade_style_id,  :min_pips,      :max_pips,
      :min_entry_time,    :max_entry_time,  :min_exit_time, :max_exit_time,
      :result,            :user_id
    )
  end

end