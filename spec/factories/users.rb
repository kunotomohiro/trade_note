FactoryBot.define do
  factory :user do
    id       { "1" }
    email    {Faker::Internet.free_email}
    password { "aaaaaaA1" }
  end 
end