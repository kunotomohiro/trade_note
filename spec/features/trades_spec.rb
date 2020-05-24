require 'rails_helper'

RSpec.feature "Trades", type: :feature do
  scenario "ユーザーは新しいトレードを作成する" do
    user = FactoryBot.create(:user)
    visit root_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "Log in"


  end
  # pending "add some scenarios (or delete) #{__FILE__}"
end
