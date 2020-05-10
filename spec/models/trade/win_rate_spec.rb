RSpec.describe Trade, type: :model do
  describe '勝率メソッドテスト' do
    let(:trade) { create(:trade) }
    let(:user_trades)          { Trade.where("(user_id = ?) and (trade_category_id = ?)", trade.user.id, trade.trade_category_id) }
    let(:win_number_of_trades) { user_trades.where("result" => "資産増") }
    let(:total_win_rate)       { "#{(win_number_of_trades.count / user_trades.count.to_f * 100).floor(1)}%" }
    let(:trades)               { win_number_of_trades.where("trade_style_id" => trade.trade_style_id).count }
    let(:trade_style_win_rate) { "#{(trades / user_trades.count.to_f * 100).floor(1)}%" }
    context 'user_idとtrade_category_idが渡ってきた時' do
      it "trade_category_idに紐付くユーザーのトレードを返す" do
        expect(user_trades).to include(trade)
      end
    end

    context 'trade_category_idに紐付くユーザーのトレードがあった場合' do
      it "資産増のトレードを返す" do
        expect(win_number_of_trades).to include(trade)
      end
    end

    context '資産増のトレードがあった場合' do
      it "全体の勝率を返す" do
        expect(total_win_rate).to eq("100.0%")
      end
    end

    context 'トレードスタイルに紐付く資産増のトレードがあった場合' do
      it "トレードスタイルの勝率を返す" do
        expect(trade_style_win_rate).to eq("100.0%")
      end
    end

    context '資産増のトレードがなかった場合' do
      let(:trade) { create(:trade, result: "変化なし") }
      let(:win_number_of_trades) { user_trades.where("result" => "資産増") }
      it "trueを返す" do
        expect(win_number_of_trades.count === 0).to eq(true)
      end
    end
  end
end