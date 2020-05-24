require 'rails_helper'
RSpec.describe Trade, type: :model do
  describe '年内勝率メソッドテスト' do
    let(:trade)                         { create(:trade2) }
    let(:from)                          { DateTime.now.at_beginning_of_year }
    let(:to)                            { DateTime.now.at_end_of_year }
    let(:search_trades_in_year)         { Trade.where(exit_time: from..to) }
    let(:user_trades_in_year)           { Trade.where("(user_id = ?) and (trade_category_id = ?)", trade.user.id, trade.trade_category_id).where(exit_time: from..to) }
    let(:win_number_of_trades_in_year)  { user_trades_in_year.where("result" => "資産増") }
    let(:total_win_rate_in_year)        { "#{(win_number_of_trades_in_year.count / user_trades_in_year.count.to_f * 100).floor(1)}%" }
    let(:trades)                        { win_number_of_trades_in_year.where("trade_style_id" => trade.trade_style_id).count }
    let(:trade_style_win_rate_in_year)  { "#{(trades / user_trades_in_year.count.to_f * 100).floor(1)}%" }
    it "年内のトレードを返す" do
      expect(search_trades_in_year).to include(trade)
    end

    context '年内のトレードがあった場合' do
      it "年内のtrade_category_idに紐付くユーザーのトレードを返す" do
        expect(user_trades_in_year).to include(trade)
      end
    end

    context 'trade_category_idに紐付くユーザーのトレードがあった場合' do
      it "資産増のトレードを返す" do
        expect(win_number_of_trades_in_year).to include(trade)
      end
    end

    context '資産増のトレードがあった場合' do
      it "全体の勝率を返す" do
        expect(total_win_rate_in_year).to eq("100.0%")
      end
    end

    context 'トレードスタイルに紐付く資産増のトレードがあった場合' do
      it "トレードスタイルの勝率を返す" do
        expect(trade_style_win_rate_in_year).to eq("100.0%")
      end
    end

    context '資産増のトレードがなかった場合' do
      let(:trade) { create(:trade, result: "変化なし") }
      let(:win_number_of_trades) { user_trades_in_year.where("result" => "資産増") }
      it "trueを返す" do
        expect(win_number_of_trades_in_year.count === 0).to eq(true)
      end
    end
  end
end