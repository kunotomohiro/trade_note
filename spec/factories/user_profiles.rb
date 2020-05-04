FactoryBot.define do
  factory :user_profile do
    nickname { "Fxの神" }
    association :user
  end 
end