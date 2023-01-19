FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:5) }
    email { Faker::Internet.email }
    member { Faker::Lorem.characters(number:20) }
  end
    
end
