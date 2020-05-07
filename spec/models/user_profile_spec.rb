require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  describe 'バリデーション' do
    let(:user_profile) { build(:user_profile) }
    subject { user_profile.valid? }
    context '条件を満たしている場合' do
      it 'trueを返す' do
        is_expected.to eq(true)
      end
    end

    context 'ニックネームがない場合' do
      it 'trueを返す' do
        user_profile.nickname = ""
        is_expected.to eq(false)
      end
    end

    context '文字数が上限を超えている場合' do
      it 'trueを返す' do
        user_profile.nickname = "えふえっくすのかみ"
        is_expected.to eq(false)
      end
    end
  end
end