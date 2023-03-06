FactoryBot.define do
  factory :studio do
    sequence(:name) { |n| "studio#{n}" }
  end
end
