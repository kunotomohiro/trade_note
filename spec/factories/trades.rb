FactoryBot.define do
  factory :trade do
    sequence(:id)     { |n| "#{n}" }
    trade_style_id    { "1" }
    trade_category_id { "1" }
    result            { "資産増" }
    pips              { "100" }
    content           { "移動平均線の交わり" }
    entry_time        { "2018-11-11 12:00:00" }
    exit_time         { "2019-12-11 12:00:00" }
    image             {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '1.jpg'), 'image/jpg')}
    association :user
    association :trade_category
    association :trade_style
  end
end