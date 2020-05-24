require 'rails_helper'
RSpec.describe Trade, type: :model do
  describe '検索メソッドテスト' do
    let(:trade) { create(:trade) }
    context 'Userのidが渡ってきた時' do
      let(:user) { create(:trades_user) }
      let(:trade) { create(:trade, user: user) }
      it "Userのidに紐付くトレードを返す" do
        expect(Trade.search_by_user_id("1")).to include(trade)
      end
    end

    context 'params[:trade_category]が1の時' do
      it "trade_categoryが1のトレードを返す" do
        expect(Trade.search_by_trade_category("1")).to include(trade)
      end
    end

    context 'params[:search_by_trade_style]が1の時' do
      it "trade_styleが1のトレードを返す" do
        expect(Trade.search_by_trade_style("1")).to include(trade)
      end
    end

    context 'params[:min_pips]が99の時' do
      it "pipsが99以上のトレードを返す" do
        pending "一旦保留"
        # expect(Trade.search_by_min_pips("99")).to include(trade)
      end
    end

    context 'params[:min_pips]が101の時' do
      it "pipsが101以下のトレードを返す" do
        pending "一旦保留"
        # expect(Trade.search_by_max_pips("101")).to include(trade)
      end
    end

    context 'params[:min_entry_time]が2018-11-10の時' do
      it "2018-11-10以降のトレードを返す" do
        expect(Trade.search_by_upper_entry_time("2018-11-10")).to include(trade)
      end
    end

    context 'params[:max_entry_time]が2018-11-12の時' do
      it "2018-11-12以前のトレードを返す" do
        expect(Trade.search_by_lower_entry_time("2018-11-12")).to include(trade)
      end
    end

    context 'params[:min_exit_time]が2019-12-10の時' do
      it "2019-12-10以降のトレードを返す" do
        expect(Trade.search_by_upper_exit_time("2019-12-10")).to include(trade)
      end
    end

    context 'params[:max_exit_time]が2019-12-12の時' do
      it "2019-12-12以前のトレードを返す" do
        expect(Trade.search_by_lower_exit_time("2019-12-12")).to include(trade)
      end
    end

    context 'resultが資産増の時' do
      it "資産増のトレードを返す" do
        expect(Trade.search_by_result("資産増")).to include(trade)
      end
    end
  end
end