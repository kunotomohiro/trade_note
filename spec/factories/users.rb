FactoryBot.define do
  factory :user do
    sequence(:id) { |n| "#{n}" }
    email    {Faker::Internet.free_email}
    password { "aaaaaaA1" }
  end

  factory :trades_user, class: User do
    sequence(:id) { "1" }
    email    {Faker::Internet.free_email}
    password { "aaaaaaA1" }
  end 
end