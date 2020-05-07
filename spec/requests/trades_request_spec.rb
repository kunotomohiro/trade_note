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

  describe "#new" do
    context "ユーザー登録している場合" do
      let(:user_profile) { create(:user_profile) }
      it "200ステータスを返す" do
        sign_in user_profile.user
        get new_user_trade_url
        expect(response).to have_http_status "200"
      end
    end

    context "ユーザー登録していない場合" do
      it "302ステータスを返す" do
        get new_user_trade_url
        expect(response).to have_http_status "302"
      end
      
      it "サインイン画面にリダイレクトする" do
        get new_user_trade_url
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  # createはbase64のところをどう書けばいいか分からないので一旦保留

  describe "#show" do
    context "自分のトレードページの場合" do
      let(:trade) { create(:trade) }
      let(:user_profile) { create(:user_profile, user: trade.user) }
      it "200ステータスを返す" do
        sign_in user_profile.user
        get user_trade_url(trade)
        expect(response).to have_http_status "200"
      end
    end

    context "他人のトレードページに遷移しようとした場合" do
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

  describe "#edit" do
    context "自分のトレードの場合" do
      let(:trade) { create(:trade) }
      let(:user_profile) { create(:user_profile, user: trade.user) }
      it "200ステータスを返す" do
        sign_in user_profile.user
        get edit_user_trade_url(trade.id)
        expect(response).to have_http_status "200"
      end
    end

    context "他人のトレードの場合" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:trade) { create(:trade, user: other_user) }
      it "user_trades_pathにリダイレクトされる" do
        sign_in user
        get edit_user_trade_url(trade.id)
        expect(response).to redirect_to user_trades_path
      end
    end
  end

  # updateもbase64のところをどう書けばいいか分からないので一旦保留

  describe "#destroy" do
    context "自分のトレードの場合" do
      let(:trade) { create(:trade) }
      let(:user_profile) { create(:user_profile, user: trade.user) }
      it "削除できる" do
        sign_in user_profile.user
        expect{ delete user_trade_url(trade.id) }.to change(Trade, :count).by(-1)
      end
    end

    # いろいろ調べたが解決できなかったので保留
    # context "他人のトレードの場合" do
    #   let(:user) { create(:user) }
    #   let(:other_user) { create(:user) }
    #   let(:trade) { create(:trade, user: other_user) }
    #   it "削除できない" do
    #     sign_in user
    #     expect{ delete user_trade_url(trade.id) }.to_not change(Trade, :count)
    #   end
    # end
  end
end
