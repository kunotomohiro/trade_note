require 'rails_helper'

RSpec.describe "Trades", type: :request do
  describe "#index" do
    context "ユーザー登録している場合" do
      let(:user_profile) { create(:user_profile) }
      it "200ステータスを返す" do
        sign_in user_profile.user
        get user_trades_url
        expect(response).to have_http_status "200"
      end
    end

    context "ユーザー登録していない場合" do
      it "302ステータスを返す" do
        get user_trades_url
        expect(response).to have_http_status "302"
      end
      
      it "サインイン画面にリダイレクトする" do
        get user_trades_url
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do
    context "自分のトレードページの場合" do
      let(:trade) { create(:trade) }
      let(:user_profile) { create(:user_profile, user: trade.user) }
      it "200ステータスを返す" do
        sign_in user_profile.user
        get user_trade_url(trade.id)
        expect(response).to have_http_status "200"
      end
    end

    context "他人のユーザーページに遷移しようとした場合" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:trade) { create(:trade, user: other_user) }
      it "user_trades_pathにリダイレクトされる" do
        sign_in user
        get user_trade_url(trade.id)
        expect(response).to redirect_to user_trades_path
      end
    end
  end
end
