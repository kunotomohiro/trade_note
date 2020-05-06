FactoryBot.define do
  factory :user_profile do
    nickname { "Fxの神" }
    avatar   {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '1.jpg'), 'image/jpg')}
    association :user
  end 
end