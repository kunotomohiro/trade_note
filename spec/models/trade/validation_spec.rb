RSpec.describe Trade, type: :model do
  describe 'バリデーション' do
    let(:trade) { build(:trade) }
    subject { trade.valid? }
    context '全ての条件を満たしている場合' do
      it "trueを返す" do
        is_expected.to eq(true)
      end
    end

    context 'resultがない場合' do
      it 'falseを返す' do
        trade.result = ""
        is_expected.to eq(false)
      end
    end

    context 'pipsがない場合' do
      it 'falseを返す' do
        trade.pips = ""
        is_expected.to eq(false)
      end
    end

    context 'entry_timeがない場合' do
      it 'falseを返す' do
        trade.entry_time = ""
        is_expected.to eq(false)
      end
    end

    context 'exit_timeがない場合' do
      it 'falseを返す' do
        trade.exit_time = ""
        is_expected.to eq(false)
      end
    end
  end
end