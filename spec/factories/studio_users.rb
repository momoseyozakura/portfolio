FactoryBot.define do
  factory :studio_user do
    association :user
    studio_id { 1 }
    lottely { Faker::Number.between(to: 99) }
  end
end
