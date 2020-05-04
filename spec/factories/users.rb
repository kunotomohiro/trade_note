FactoryBot.define do
  factory :user do
    id                    {"1"}
    email                 {Faker::Internet.free_email}
    password              {"aaaaaaB1"}
    password_confirmation {"aaaaaaB1"}
  end
end
