FactoryBot.define do
  factory :user do
    email    {Faker::Internet.free_email}
    password { "aaaaaaA1" }
  end 
end