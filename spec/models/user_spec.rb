require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    let(:user) { User.new( email: 'test@gmail.com', password: password ) }
    subject { user.valid? }
    context '全ての条件を満たしている場合' do
      let(:password) { 'aaaaaaA1' }
      it 'trueを返す' do
        is_expected.to eq(true)
      end
    end

    context '小文字のみの場合' do
      let(:password) { 'aaaaaaaa' }
      it 'falseを返す' do
        is_expected.to eq(false)
      end
    end

    context '小文字 + 大文字の場合' do
      let(:password) { 'aaaaaaaA' }
      it 'falseを返す' do
        is_expected.to eq(false)
      end
    end

    context '小文字 + 数字の場合' do
      let(:password) { 'aaaaaaa1' }
      it 'falseを返す' do
        is_expected.to eq(false)
      end
    end

    context '条件を満たしてても文字数が足りない場合' do
      let(:password) { 'aaaaaA1' }
      it 'falseを返す' do
        is_expected.to eq(false)
      end
    end
  end
end