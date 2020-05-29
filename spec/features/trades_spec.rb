require 'rails_helper'

RSpec.feature "Trades", type: :feature do
  scenario "ユーザーは新しいトレードを作成する" do
    user = FactoryBot.create(:user)
    visit root_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "ログイン"
    expect(current_path).to eq user_trades_path
  end
  # pending "add some scenarios (or delete) #{__FILE__}"
end
